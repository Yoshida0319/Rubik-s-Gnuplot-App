import numpy as np

#U0 F1 R2 B3 L4 D5  白1 緑2 赤3 青4 橙5 黄6
#i:面の色  con:センターの色

def huriwake(i,con,nasuka):#数字による振り分け
    mov = 0
    for jjj in range(nasuka[1]):
        if nasuka[0] == 0:
            i = UU(i)
            mov = 1
        elif nasuka[0] == 1:
            i = FF(i)
            mov = 1
        elif nasuka[0] == 2:
            i = RR(i)
            mov = 1
        elif nasuka[0] == 3:
            i = BB(i)
            mov = 1
        elif nasuka[0] == 4:
            i = LL(i)
            mov = 1
        elif nasuka[0] == 5:
            i = DD(i)
            mov = 1
        elif nasuka[0] == 10:
            i, con = XX(i,con)
        elif nasuka[0] == 11:
            i, con = YY(i,con)
        elif nasuka[0] == 12:
            i, con = ZZ(i,con)
        elif nasuka[0] == 13:
            i, con = mm(i,con)
            mov = 2
        elif nasuka[0] == 14:
            i, con = ee(i,con)
            mov = 2
        elif nasuka[0] == 15:
            i, con = ss(i,con)
            mov = 2
        elif nasuka[0] == 20:
            i, con = Uw(i,con)
            mov = 1
        elif nasuka[0] == 21:
            i, con = Fw(i,con)
            mov = 1
        elif nasuka[0] == 22:
            i, con = Rw(i,con)
            mov = 1
        elif nasuka[0] == 23:
            i, con = Bw(i,con)
            mov = 1
        elif nasuka[0] == 24:
            i, con = Lw(i,con)
            mov = 1
        elif nasuka[0] == 25:
            i, con = Dw(i,con)
            mov = 1
    return i, con, mov
#U0 F1 R2 B3 L4 D5 X10(R) Y11(U) Z12(F) m13(L) e14(D) s15(F) Uw20 Fw21 Rw22 Bw23 Lw24 Dw25

def kaiten(mme,i):#一面の回転
    cop = np.copy(i[mme])
    i[mme] = np.concatenate([cop[6:],cop[:6]])
    return i

def UU(i):
    i = kaiten(0,i)
    cop = np.copy(i[1][:3])
    i[1][:3] = np.copy(i[2][:3])
    i[2][:3] = np.copy(i[3][:3])
    i[3][:3] = np.copy(i[4][:3])
    i[4][:3] = np.copy(cop)
    return i

def FF(i):
    i = kaiten(1,i)
    cop = np.copy(i[0][4:7])
    i[0][4:7] = np.copy(i[4][2:5])
    i[4][2:5] = np.copy(i[5][:3])
    i[5][:2] = np.copy(i[2][6:])
    i[5][2] = np.copy(i[2][0])
    i[2][0] = np.copy(cop[2])
    i[2][6:] = np.copy(cop[:2])
    return i

def RR(i):
    i = kaiten(2,i)
    cop = np.copy(i[0][2:5])
    i[0][2:5] = np.copy(i[1][2:5])
    i[1][2:5] = np.copy(i[5][2:5])
    i[5][2:4] = np.copy(i[3][6:])
    i[5][4] = np.copy(i[3][0])
    i[3][6:] = np.copy(cop[:2])
    i[3][0] = np.copy(cop[2])
    return i

def BB(i):
    i = kaiten(3,i)
    cop = np.copy(i[0][:3])
    i[0][:3] = np.copy(i[2][2:5])
    i[2][2:5] = np.copy(i[5][4:7])
    i[5][4:6] = np.copy(i[4][6:])
    i[5][6] = np.copy(i[4][0])
    i[4][0] = np.copy(cop[2])
    i[4][6:] = np.copy(cop[:2])
    return i

def LL(i):
    i = kaiten(4,i)
    cop = np.copy(i[0])
    i[0][0] = np.copy(i[3][4])
    i[0][6:] = np.copy(i[3][2:4])
    i[3][2:4] = np.copy(i[5][6:])
    i[3][4] = np.copy(i[5][0])
    i[5][0] = np.copy(i[1][0])
    i[5][6:] = np.copy(i[1][6:])
    i[1][0] = np.copy(cop[0])
    i[1][6:] = np.copy(cop[6:])
    return i

def DD(i):
    i = kaiten(5,i)
    cop = np.copy(i[1][4:7])
    i[1][4:7] = np.copy(i[4][4:7])
    i[4][4:7] = np.copy(i[3][4:7])
    i[3][4:7] = np.copy(i[2][4:7])
    i[2][4:7] = np.copy(cop)
    return i

def XX(i,con):
    i = RR(i)
    i = LL(i)
    i = LL(i)
    i = LL(i)
    cop = np.copy(i[0])
    i[0][1] = np.copy(i[1][1])
    i[0][5] = np.copy(i[1][5])
    i[1][1] = np.copy(i[5][1])
    i[1][5] = np.copy(i[5][5])
    i[5][1] = np.copy(i[3][5])
    i[5][5] = np.copy(i[3][1])
    i[3][5] = np.copy(cop[1])
    i[3][1] = np.copy(cop[5])
    con = Xcon(con)
    return i,con

def YY(i,con):
    i = UU(i)
    i = DD(i)
    i = DD(i)
    i = DD(i)
    cop = np.copy(i[1])
    i[1][3] = np.copy(i[2][3])
    i[1][7] = np.copy(i[2][7])
    i[2][3] = np.copy(i[3][3])
    i[2][7] = np.copy(i[3][7])
    i[3][3] = np.copy(i[4][3])
    i[3][7] = np.copy(i[4][7])
    i[4][3] = np.copy(cop[3])
    i[4][7] = np.copy(cop[7])
    con = Ycon(con)
    return i,con

def ZZ(i,con):
    i = FF(i)
    i = BB(i)
    i = BB(i)
    i = BB(i)
    cop = np.copy(i[0])
    i[0][3] = np.copy(i[4][1])
    i[0][7] = np.copy(i[4][5])
    i[4][1] = np.copy(i[5][7])
    i[4][5] = np.copy(i[5][3])
    i[5][3] = np.copy(i[2][1])
    i[5][7] = np.copy(i[2][5])
    i[2][1] = np.copy(cop[7])
    i[2][5] = np.copy(cop[3])
    con = Zcon(con)
    return i,con

def Xcon(con):#センターの回転
    cop = np.copy(con[0])
    con[0] = np.copy(con[1])
    con[1] = np.copy(con[5])
    con[5] = np.copy(con[3])
    con[3] = np.copy(cop)
    return con

def Ycon(con):
    cop = np.copy(con[1])
    con[1] = np.copy(con[2])
    con[2] = np.copy(con[3])
    con[3] = np.copy(con[4])
    con[4] = np.copy(cop)
    return con

def Zcon(con):
    cop = np.copy(con[0])
    con[0] = np.copy(con[4])
    con[4] = np.copy(con[5])
    con[5] = np.copy(con[2])
    con[2] = np.copy(cop)
    return con

def Uw(i,con):
    i, con = YY(i,con)
    i = DD(i)
    return i, con

def Dw(i,con):
    i, con = YY(i,con)
    i, con = YY(i,con)
    i, con = YY(i,con)
    i = UU(i)
    return i, con

def Fw(i,con):
    i, con = ZZ(i,con)
    i = BB(i)
    return i, con

def Bw(i,con):
    i, con = ZZ(i,con)
    i, con = ZZ(i,con)
    i, con = ZZ(i,con)
    i = FF(i)
    return i, con

def Rw(i,con):
    i, con = XX(i,con)
    i = LL(i)
    return i, con

def Lw(i,con):
    i, con = XX(i,con)
    i, con = XX(i,con)
    i, con = XX(i,con)
    i = RR(i)
    return i, con

def mm(i,con):
    i, con = Lw(i,con)
    i = LL(i)
    i = LL(i)
    i = LL(i)
    return i, con

def ee(i,con):
    i ,con = Dw(i,con)
    i = DD(i)
    i = DD(i)
    i = DD(i)
    return i, con

def ss(i,con):
    i ,con = Fw(i,con)
    i = FF(i)
    i = FF(i)
    i = FF(i)
    return i, con