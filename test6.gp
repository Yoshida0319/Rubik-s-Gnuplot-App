load 'datitic.txt'

set output "test6.gif"#ファイル名
set object 1 rect behind from screen 0,0 to screen 1,1 fc rgb "light-gray" fs solid 1.0#背景薄灰色に設定
set terminal gif animate delay 5#gif設定、delayは0.001*5(影響なし)
set view 75,120,2#視点変更、x周り、z周り、拡大率
set xyplane at -20#xy平面をz軸上で平行移動
set parametric#媒介変数使用
set view equal xyz#表示を均等に
set urange[-50:50]
set vrange[-50:50]
unset key#グラフタイトル非表示
set hidden3d#グラフの後ろのグラフを透過させない
set isosamples 50, 50#メッシュの細かさ
unset border#軸非表示
unset tics#目盛非表示
#nsa = 1#繰り返し数
#com = 0#操作コマンド

if (nsa == 1){
    sita(j) = pi * 0.5 * sin(0.5*pi*j/30.)
}else if(nsa == 2){
    sita(j) = pi * sin(0.5*pi*j/30.)
}else if(nsa == 3){
    sita(j) = pi * -0.5 * sin(0.5*pi*j/30.)
}
tesb(u,v,j) = (abs(u) < 30 && abs(v) < 30 && j < 30 ? 10 : 1/0)
tesbb(u,v,j) = (abs(urx(u,v,j)) < 30 && abs(ury(u,v,j)) < 30 && abs(j) < 30 ? 10 : 1/0)
urx(u,v,j) = u*cos(sita(j)) + v*sin(sita(j))
ury(u,v,j) = -u*sin(sita(j)) + v*cos(sita(j))
usx(u,v,j) = u*cos(sita(j)) - v*sin(sita(j))
usy(u,v,j) = u*sin(sita(j)) + v*cos(sita(j))
w0(u,v,j) = (abs(urx(u,v,j)     ) < 10 && abs(ury(u,v,j)     ) < 10 ? 30 : 1/0)
w1(u,v,j) = (abs(urx(u,v,j) + 20) < 10 && abs(ury(u,v,j) + 20) < 10 ? 30 : 1/0)
w2(u,v,j) = (abs(urx(u,v,j) + 20) < 10 && abs(ury(u,v,j)     ) < 10 ? 30 : 1/0)
w3(u,v,j) = (abs(urx(u,v,j) + 20) < 10 && abs(ury(u,v,j) - 20) < 10 ? 30 : 1/0)
w4(u,v,j) = (abs(urx(u,v,j)     ) < 10 && abs(ury(u,v,j) - 20) < 10 ? 30 : 1/0)
w5(u,v,j) = (abs(urx(u,v,j) - 20) < 10 && abs(ury(u,v,j) - 20) < 10 ? 30 : 1/0)
w6(u,v,j) = (abs(urx(u,v,j) - 20) < 10 && abs(ury(u,v,j)     ) < 10 ? 30 : 1/0)
w7(u,v,j) = (abs(urx(u,v,j) - 20) < 10 && abs(ury(u,v,j) + 20) < 10 ? 30 : 1/0)
w8(u,v,j) = (abs(urx(u,v,j)     ) < 10 && abs(ury(u,v,j) + 20) < 10 ? 30 : 1/0)
ggx1(u,v,j) = (abs(u + 20) < 10 && abs(v - 20) < 10 ? u*cos(sita(j)) - 30*sin(sita(j)) : 1/0)
ggx2(u,v,j) = (abs(u     ) < 10 && abs(v - 20) < 10 ? u*cos(sita(j)) - 30*sin(sita(j)) : 1/0)
ggx3(u,v,j) = (abs(u - 20) < 10 && abs(v - 20) < 10 ? u*cos(sita(j)) - 30*sin(sita(j)) : 1/0)
ggy1(u,v,j) = (abs(u + 20) < 10 && abs(v - 20) < 10 ? u*sin(sita(j)) + 30*cos(sita(j)) : 1/0)
ggy2(u,v,j) = (abs(u     ) < 10 && abs(v - 20) < 10 ? u*sin(sita(j)) + 30*cos(sita(j)) : 1/0)
ggy3(u,v,j) = (abs(u - 20) < 10 && abs(v - 20) < 10 ? u*sin(sita(j)) + 30*cos(sita(j)) : 1/0)

str = "splot"
array clo[9] = ["white", "green", "red", "blue", "orange", "yellow", "black", "gray", "purple"]
array tkr[54]

do for [kiss=0:8]{
    tkr[1+kiss] = sprintf(" u, v, w%d(u,v,0)", kiss)
    tkr[10+kiss] = sprintf(" w%d(u,v,0), v, -u", kiss)
    tkr[19+kiss] = sprintf(" -v, w%d(u,v,0), -u", kiss)
    tkr[28+kiss] = sprintf(" -w%d(u,v,0), -v, -u", kiss)
    tkr[37+kiss] = sprintf(" v, -w%d(u,v,0), -u", kiss)
    tkr[46+kiss] = sprintf(" -u, v, -w%d(u,v,0)", kiss)
}

if(com == 0 || com == 5 || com == 11 || com == 14 || com == 20 || com == 25){#U系統一括
    if(com == 0 || com == 11 || com == 20){#上面0
        do for [keti=0:8]{
            tkr[1+keti] = sprintf(" u, v, w%d(u,v,-j)", keti)
        }
    }
    if(com == 5 || com == 11 || com == 25){#下面5
        do for [keti=0:8]{
            if(com == 11){
                tkr[46+keti] = sprintf(" -u, v, -w%d(u,v,j)", keti)
            }else{
                tkr[46+keti] = sprintf(" -u, v, -w%d(u,v,-j)", keti)
            }
        }
    }
    if(com == 0 || com == 11 || com == 20){#3段目_3,4,5
        tkr[10+1] = sprintf(" ggy3(u,v,-j), -ggx3(u,v,-j), v")
        tkr[10+2] = sprintf(" ggy2(u,v,-j), -ggx2(u,v,-j), v")
        tkr[10+3] = sprintf(" ggy1(u,v,-j), -ggx1(u,v,-j), v")
        tkr[19+1] = sprintf(" ggx3(u,v,-j), ggy3(u,v,-j), v")
        tkr[19+2] = sprintf(" ggx2(u,v,-j), ggy2(u,v,-j), v")
        tkr[19+3] = sprintf(" ggx1(u,v,-j), ggy1(u,v,-j), v")
        tkr[28+1] = sprintf(" -ggy3(u,v,-j), ggx3(u,v,-j), v")
        tkr[28+2] = sprintf(" -ggy2(u,v,-j), ggx2(u,v,-j), v")
        tkr[28+3] = sprintf(" -ggy1(u,v,-j), ggx1(u,v,-j), v")
        tkr[37+1] = sprintf(" -ggx3(u,v,-j), -ggy3(u,v,-j), v")
        tkr[37+2] = sprintf(" -ggx2(u,v,-j), -ggy2(u,v,-j), v")
        tkr[37+3] = sprintf(" -ggx1(u,v,-j), -ggy1(u,v,-j), v")
    }
    if(com != 0 && com != 5){#2段目_0,2,6
        if(com == 11 || com == 20){
            nasubi = "-j"
        }else{
            nasubi = "j"
        }
        tkr[10+0] = sprintf(" ggy2(u,v+20,%s), -ggx2(u,v+20,%s), v", nasubi, nasubi)
        tkr[10+4] = sprintf(" ggy1(u,v+20,%s), -ggx1(u,v+20,%s), v", nasubi, nasubi)
        tkr[10+8] = sprintf(" ggy3(u,v+20,%s), -ggx3(u,v+20,%s), v", nasubi, nasubi)
        tkr[19+0] = sprintf(" ggx2(u,v+20,%s), ggy2(u,v+20,%s), -v", nasubi, nasubi)
        tkr[19+4] = sprintf(" ggx1(u,v+20,%s), ggy1(u,v+20,%s), -v", nasubi, nasubi)
        tkr[19+8] = sprintf(" ggx3(u,v+20,%s), ggy3(u,v+20,%s), -v", nasubi, nasubi)
        tkr[28+0] = sprintf(" -ggy2(u,v+20,%s), ggx2(u,v+20,%s), v", nasubi, nasubi)
        tkr[28+4] = sprintf(" -ggy1(u,v+20,%s), ggx1(u,v+20,%s), v", nasubi, nasubi)
        tkr[28+8] = sprintf(" -ggy3(u,v+20,%s), ggx3(u,v+20,%s), v", nasubi, nasubi)
        tkr[37+0] = sprintf(" -ggx2(u,v+20,%s), -ggy2(u,v+20,%s), -v", nasubi, nasubi)
        tkr[37+4] = sprintf(" -ggx1(u,v+20,%s), -ggy1(u,v+20,%s), -v", nasubi, nasubi)
        tkr[37+8] = sprintf(" -ggx3(u,v+20,%s), -ggy3(u,v+20,%s), -v", nasubi, nasubi)
    }
    if(com == 5 || com == 11 || com == 25){#1段目_1,7,8
        if(com == 11){
            nasubi = "-j"
        }else{
            nasubi = "j"
        }
        tkr[10+5] = sprintf(" ggy1(u,v,%s), -ggx1(u,v,%s), -v", nasubi, nasubi)
        tkr[10+6] = sprintf(" ggy2(u,v,%s), -ggx2(u,v,%s), -v", nasubi, nasubi)
        tkr[10+7] = sprintf(" ggy3(u,v,%s), -ggx3(u,v,%s), -v", nasubi, nasubi)
        tkr[19+5] = sprintf(" ggx1(u,v,%s), ggy1(u,v,%s), -v", nasubi, nasubi)
        tkr[19+6] = sprintf(" ggx2(u,v,%s), ggy2(u,v,%s), -v", nasubi, nasubi)
        tkr[19+7] = sprintf(" ggx3(u,v,%s), ggy3(u,v,%s), -v", nasubi, nasubi)
        tkr[28+5] = sprintf(" -ggy1(u,v,%s), ggx1(u,v,%s), -v", nasubi, nasubi)
        tkr[28+6] = sprintf(" -ggy2(u,v,%s), ggx2(u,v,%s), -v", nasubi, nasubi)
        tkr[28+7] = sprintf(" -ggy3(u,v,%s), ggx3(u,v,%s), -v", nasubi, nasubi)
        tkr[37+5] = sprintf(" -ggx1(u,v,%s), -ggy1(u,v,%s), -v", nasubi, nasubi)
        tkr[37+6] = sprintf(" -ggx2(u,v,%s), -ggy2(u,v,%s), -v", nasubi, nasubi)
        tkr[37+7] = sprintf(" -ggx3(u,v,%s), -ggy3(u,v,%s), -v", nasubi, nasubi)
    }
    if (com == 0){
        str = str . " u, v, tesb(u,v,j) lc rgb 'black',"
    }else if (com == 5){
        str = str . " u, v, -tesbb(u,v,j) lc rgb 'black',"
    }else if (com == 14){
        str = str . " u, v, tesbb(u,v,j) lc rgb 'black',"
        str = str . " u, v, -tesb(u,v,j) lc rgb 'black',"
    }else if (com == 20){
        str = str . " u, v, -tesb(u,v,j) lc rgb 'black',"
    }else if (com == 25){
        str = str . " u, v, tesbb(u,v,j) lc rgb 'black',"
    }
}

if(com == 1 || com == 3 || com == 12 || com == 15 || com == 21 || com == 23){#F系統一括
    if(com == 1 || com == 12 || com == 21){#前面1
        do for [keti=0:8]{
            tkr[10+keti] = sprintf(" w%d(u,v,-j), v, -u", keti)
        }
    }
    if(com == 3 || com == 12 || com == 23){#後面3
        do for [keti=0:8]{
            if(com == 12){
                tkr[28+keti] = sprintf(" -w%d(u,v,j), -v, -u", keti)
            }else{
                tkr[28+keti] = sprintf(" -w%d(u,v,-j), -v, -u", keti)
            }
        }
    }
    if(com == 1 || com == 12 || com == 21){#3段目
        tkr[1+5] = sprintf(" v, -ggx1(u,v,j), ggy1(u,v,j)")
        tkr[1+6] = sprintf(" v, -ggx2(u,v,j), ggy2(u,v,j)")
        tkr[1+7] = sprintf(" v, -ggx3(u,v,j), ggy3(u,v,j)")
        tkr[19+1] = sprintf(" v, ggy1(u,v,-j), -ggx1(u,v,-j)")
        tkr[19+8] = sprintf(" v, ggy2(u,v,-j), -ggx2(u,v,-j)")
        tkr[19+7] = sprintf(" v, ggy3(u,v,-j), -ggx3(u,v,-j)")
        tkr[37+3] = sprintf(" v, -ggy3(u,v,-j), ggx3(u,v,-j)")
        tkr[37+4] = sprintf(" v, -ggy2(u,v,-j), ggx2(u,v,-j)")
        tkr[37+5] = sprintf(" v, -ggy1(u,v,-j), ggx1(u,v,-j)")
        tkr[46+1] = sprintf(" v, ggx1(u,v,j), -ggy1(u,v,j)")
        tkr[46+2] = sprintf(" v, ggx2(u,v,j), -ggy2(u,v,j)")
        tkr[46+3] = sprintf(" v, ggx3(u,v,j), -ggy3(u,v,j)")
    }
    if(com != 1 && com != 3){#2段目
        if(com == 12 || com == 15 || com == 21){
            nasubi = "j"
        }else{
            nasubi = "-j"
        }
        tkr[1+0] = sprintf(" v, -ggx2(u,v+20,%s), ggy2(u,v+20,%s)", nasubi, nasubi)
        tkr[1+4] = sprintf(" v, -ggx1(u,v+20,%s), ggy1(u,v+20,%s)", nasubi, nasubi)
        tkr[1+8] = sprintf(" v, -ggx3(u,v+20,%s), ggy3(u,v+20,%s)", nasubi, nasubi)
        tkr[19+0] = sprintf(" v, ggy2(u,v+20,-1*%s), -ggx2(u,v+20,-1*%s)", nasubi, nasubi)
        tkr[19+2] = sprintf(" v, ggy1(u,v+20,-1*%s), -ggx1(u,v+20,-1*%s)", nasubi, nasubi)
        tkr[19+6] = sprintf(" v, ggy3(u,v+20,-1*%s), -ggx3(u,v+20,-1*%s)", nasubi, nasubi)
        tkr[37+0] = sprintf(" v, -ggy2(u,v+20,-1*%s), ggx2(u,v+20,-1*%s)", nasubi, nasubi)
        tkr[37+2] = sprintf(" v, -ggy3(u,v+20,-1*%s), ggx3(u,v+20,-1*%s)", nasubi, nasubi)
        tkr[37+6] = sprintf(" v, -ggy1(u,v+20,-1*%s), ggx1(u,v+20,-1*%s)", nasubi, nasubi)
        tkr[46+0] = sprintf(" v, ggx2(u,v+20,%s), -ggy2(u,v+20,%s)", nasubi, nasubi)
        tkr[46+4] = sprintf(" v, ggx3(u,v+20,%s), -ggy3(u,v+20,%s)", nasubi, nasubi)
        tkr[46+8] = sprintf(" v, ggx1(u,v+20,%s), -ggy1(u,v+20,%s)", nasubi, nasubi)
    }
    if(com == 3 || com == 12 || com == 23){#1段目
        if(com == 12){
            nasubi = "-j"
        }else{
            nasubi = "j"
        }
        tkr[1+1] = sprintf(" -v, -ggx3(u,v,-1*%s), ggy3(u,v,-1*%s)", nasubi, nasubi)
        tkr[1+2] = sprintf(" -v, -ggx2(u,v,-1*%s), ggy2(u,v,-1*%s)", nasubi, nasubi)
        tkr[1+3] = sprintf(" -v, -ggx1(u,v,-1*%s), ggy1(u,v,-1*%s)", nasubi, nasubi)
        tkr[19+3] = sprintf(" -v, ggy1(u,v,%s), -ggx1(u,v,%s)", nasubi, nasubi)
        tkr[19+4] = sprintf(" -v, ggy2(u,v,%s), -ggx2(u,v,%s)", nasubi, nasubi)
        tkr[19+5] = sprintf(" -v, ggy3(u,v,%s), -ggx3(u,v,%s)", nasubi, nasubi)
        tkr[37+1] = sprintf("  -v, -ggy3(u,v,%s), ggx3(u,v,%s)", nasubi, nasubi)
        tkr[37+7] = sprintf("  -v, -ggy1(u,v,%s), ggx1(u,v,%s)", nasubi, nasubi)
        tkr[37+8] = sprintf("  -v, -ggy2(u,v,%s), ggx2(u,v,%s)", nasubi, nasubi)
        tkr[46+5] = sprintf(" -v, ggx3(u,v,-1*%s), -ggy3(u,v,-1*%s)", nasubi, nasubi)
        tkr[46+6] = sprintf(" -v, ggx2(u,v,-1*%s), -ggy2(u,v,-1*%s)", nasubi, nasubi)
        tkr[46+7] = sprintf(" -v, ggx1(u,v,-1*%s), -ggy1(u,v,-1*%s)", nasubi, nasubi)
    }
    if (com == 1){
        str = str . " tesb(u,v,j), u, v lc rgb 'black',"
    }else if (com == 3){
        str = str . " -tesbb(u,v,j), u, v lc rgb 'black',"
    }else if (com == 15){
        str = str . " tesbb(u,v,-j), u, v lc rgb 'black',"
        str = str . " -tesb(u,v,j), u, v lc rgb 'black',"
    }else if (com == 21){
        str = str . " -tesb(u,v,j), u, v lc rgb 'black',"
    }else if (com == 23){
        str = str . " tesbb(u,v,j), u, v lc rgb 'black',"
    }
}

if(com == 2 || com == 4 || com == 10 || com == 13 || com == 22 || com == 24){#R系統一括
    if(com == 2 || com == 10 || com == 22){#右面1
        do for [keti=0:8]{
            tkr[19+keti] = sprintf(" -v, w%d(u,v,-j), -u", keti)
        }
    }
    if(com == 4 || com == 10 || com == 24){#左面3
        do for [keti=0:8]{
            if(com == 10){
                tkr[37+keti] = sprintf("  v, -w%d(u,v,j), -u", keti)
            }else{
                tkr[37+keti] = sprintf("  v, -w%d(u,v,-j), -u", keti)
            }
        }
    }
    if(com == 2 || com == 10 || com == 22){#3段目
        tkr[1+3] = sprintf(" ggx1(u,v,j), v, ggy1(u,v,j)")
        tkr[1+4] = sprintf(" ggx2(u,v,j), v, ggy2(u,v,j)")
        tkr[1+5] = sprintf(" ggx3(u,v,j), v, ggy3(u,v,j)")
        tkr[10+3] = sprintf(" ggy3(u,v,-j), v, ggx3(u,v,-j)")
        tkr[10+4] = sprintf(" ggy2(u,v,-j), v, ggx2(u,v,-j)")
        tkr[10+5] = sprintf(" ggy1(u,v,-j), v, ggx1(u,v,-j)")
        tkr[28+1] = sprintf(" -ggy1(u,v,-j), v, -ggx1(u,v,-j)")
        tkr[28+8] = sprintf(" -ggy2(u,v,-j), v, -ggx2(u,v,-j)")
        tkr[28+7] = sprintf(" -ggy3(u,v,-j), v, -ggx3(u,v,-j)")
        tkr[46+3] = sprintf(" -ggx1(u,v,j), v, -ggy1(u,v,j)")
        tkr[46+4] = sprintf(" -ggx2(u,v,j), v, -ggy2(u,v,j)")
        tkr[46+5] = sprintf(" -ggx3(u,v,j), v, -ggy3(u,v,j)")
    }
    if(com != 2 && com != 4){#2段目
        if(com == 10 || com == 22){
            nasubi = "j"
        }else{
            nasubi = "-j"
        }
        tkr[1+2] = sprintf(" ggx1(u,v+20,%s), v, ggy1(u,v+20,%s)", nasubi, nasubi)
        tkr[1+0] = sprintf(" ggx2(u,v+20,%s), v, ggy2(u,v+20,%s)", nasubi, nasubi)
        tkr[1+6] = sprintf(" ggx3(u,v+20,%s), v, ggy3(u,v+20,%s)", nasubi, nasubi)
        tkr[10+2] = sprintf(" ggy3(u,v+20,-1*%s), v, ggx3(u,v+20,-1*%s)", nasubi, nasubi)
        tkr[10+0] = sprintf(" ggy2(u,v+20,-1*%s), v, ggx2(u,v+20,-1*%s)", nasubi, nasubi)
        tkr[10+6] = sprintf(" ggy1(u,v+20,-1*%s), v, ggx1(u,v+20,-1*%s)", nasubi, nasubi)
        tkr[28+2] = sprintf(" -ggy1(u,v+20,-1*%s), v, -ggx1(u,v+20,-1*%s)", nasubi, nasubi)
        tkr[28+0] = sprintf(" -ggy2(u,v+20,-1*%s), v, -ggx2(u,v+20,-1*%s)", nasubi, nasubi)
        tkr[28+6] = sprintf(" -ggy3(u,v+20,-1*%s), v, -ggx3(u,v+20,-1*%s)", nasubi, nasubi)
        tkr[46+2] = sprintf(" -ggx1(u,v+20,%s), v, -ggy1(u,v+20,%s)", nasubi, nasubi)
        tkr[46+0] = sprintf(" -ggx2(u,v+20,%s), v, -ggy2(u,v+20,%s)", nasubi, nasubi)
        tkr[46+6] = sprintf(" -ggx3(u,v+20,%s), v, -ggy3(u,v+20,%s)", nasubi, nasubi)
    }
    if(com == 4 || com == 10 || com == 24){#1段目
        if(com == 10){
            nasubi = "-j"
        }else{
            nasubi = "j"
        }
        tkr[1+1] = sprintf(" ggx1(u,v,-1*%s), -v, ggy1(u,v,-1*%s)", nasubi, nasubi)
        tkr[1+8] = sprintf(" ggx2(u,v,-1*%s), -v, ggy2(u,v,-1*%s)", nasubi, nasubi)
        tkr[1+7] = sprintf(" ggx3(u,v,-1*%s), -v, ggy3(u,v,-1*%s)", nasubi, nasubi)
        tkr[10+1] = sprintf(" ggy3(u,v,%s), -v, ggx3(u,v,%s)", nasubi, nasubi)
        tkr[10+8] = sprintf(" ggy2(u,v,%s), -v, ggx2(u,v,%s)", nasubi, nasubi)
        tkr[10+7] = sprintf(" ggy1(u,v,%s), -v, ggx1(u,v,%s)", nasubi, nasubi)
        tkr[28+3] = sprintf("  -ggy1(u,v,%s), -v, -ggx1(u,v,%s)", nasubi, nasubi)
        tkr[28+4] = sprintf("  -ggy2(u,v,%s), -v, -ggx2(u,v,%s)", nasubi, nasubi)
        tkr[28+5] = sprintf("  -ggy3(u,v,%s), -v, -ggx3(u,v,%s)", nasubi, nasubi)
        tkr[46+1] = sprintf(" -ggx1(u,v,-1*%s), -v, -ggy1(u,v,-1*%s)", nasubi, nasubi)
        tkr[46+8] = sprintf(" -ggx2(u,v,-1*%s), -v, -ggy2(u,v,-1*%s)", nasubi, nasubi)
        tkr[46+7] = sprintf(" -ggx3(u,v,-1*%s), -v, -ggy3(u,v,-1*%s)", nasubi, nasubi)
    }
    if (com == 2){
        str = str . " u, tesb(u,v,j), v lc rgb 'black',"
    }else if (com == 4){
        str = str . " u, -tesbb(u,v,-j), v lc rgb 'black',"
    }else if (com == 13){
        str = str . " u, tesbb(u,v,-j), v lc rgb 'black',"
        str = str . " u, -tesb(u,v,j), v lc rgb 'black',"
    }else if (com == 22){
        str = str . " u, -tesb(u,v,j), v lc rgb 'black',"
    }else if (com == 24){
        str = str . " u, tesbb(u,v,-j), v lc rgb 'black',"
    }
}

do for[niss=1:9]{
    str = str . tkr[niss]
    str = str . sprintf(" lc rgb '%s',", clo[ii0[niss]])
    str = str . tkr[9+niss]
    str = str . sprintf(" lc rgb '%s',", clo[ii1[niss]])
    str = str . tkr[18+niss]
    str = str . sprintf(" lc rgb '%s',", clo[ii2[niss]])
    str = str . tkr[27+niss]
    str = str . sprintf(" lc rgb '%s',", clo[ii3[niss]])
    str = str . tkr[36+niss]
    str = str . sprintf(" lc rgb '%s',", clo[ii4[niss]])
    str = str . tkr[45+niss]
    str = str . sprintf(" lc rgb '%s'", clo[ii5[niss]])
    if(niss != 9){
        str = str . ","
    }
}

#U0 F1 R2 B3 L4 D5 X10(R) Y11(U) Z12(F) m13(L) e14(D) s15(F) Uw20 Fw21 Rw22 Bw23 Lw24 Dw25

do for [j=0:30]{
    eval(str)
}