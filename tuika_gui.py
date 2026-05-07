import streamlit as st
import subprocess
from PIL import Image
import time
import numpy as np
from ruupy_test import huriwake
from io import BytesIO
import base64
import json
import streamlit.components.v1 as components

st.session_state.i = np.array(
[[1,1,1,1,1,1,1,1],
 [2,2,2,2,2,2,2,2],
 [3,3,3,3,3,3,3,3],
 [4,4,4,4,4,4,4,4],
 [5,5,5,5,5,5,5,5],
 [6,6,6,6,6,6,6,6]]
)#面の色
st.session_state.con = np.array([1,2,3,4,5,6])#センターの色
#U0 F1 R2 B3 L4 D5  白1 緑2 赤3 青4 橙5 黄6
st.session_state.mozimozi = []
st.session_state.val = "U"
st.session_state.cm = []
st.session_state.movn = 0
st.session_state.noki = 0
st.session_state.Cerberus = ""


st.title("Rubik's Gnuplot App")


@st.fragment
def sasakusei():
    #spin = st.empty()
    main_container = st.container()
    with main_container:
        left, center, right = st.columns([0.8,3,2],vertical_alignment="center")
        with left:
            Notation_display = st.empty()

        with center:
            st.write("")
            butto, spinn = st.columns([0.325,1],vertical_alignment="center",gap="small")
            with butto:
                button_irekae(Notation_display,spinn)

        with right:
            with st.container():
                moves_display = st.empty()
    if st.session_state.noki == 0:
        vdd()
    moves(moves_display)
    move_N(Notation_display)
    if st.session_state.noki == 1:
        gnu_seisei()
        st.session_state.i, st.session_state.con, mov = huriwake(st.session_state.i, st.session_state.con, st.session_state.cm[0])
        st.session_state.movn += mov
        vdd()
        with spinn:
            with st.spinner('Go! Gnuplot!'):
                #gnuplotでGIF作成
                gp_cmd = f"load 'test6.gp'"
                subprocess.run(['gnuplot', '-e', gp_cmd])
        moves(moves_display)
        gra_saisei(1)
        move_N(Notation_display)
        st.session_state.noki = 0

def button_irekae(nosnos,niaosa):
    if st.button("Execute"):#ボタン生成
        if len(st.session_state.cm) != 0:
            st.session_state.noki = 1
    
def vdd():
    if st.session_state.noki == 1:
        naisd = list(st.session_state.val)
        naisd.pop(0)
        st.session_state.val = ''.join(naisd)
    if st.session_state.val:
        kakikomi()
        karikari()
    else:
        kakikomi()
        karikari()
        st.session_state.Cerberus = "　"
    st.text_input("Enter Notation:", key="val")#入力場所

def moves(nasnas):
    moves_suuzi = f"""
        <div style="display: flex; justify-content: flex-end; align-items: center;">
            <div style="width: fit-content; border: 1px solid #d3d3d3; border-radius: 8px; padding: 0px 12px;">
                <span style="font-weight: bold; color: gray;">Moves:　　</span>
                <span style="font-size: 24px; font-weight: bold;">{st.session_state.movn}</span>
            </div>
        </div>
        """
    nasnas.markdown(moves_suuzi, unsafe_allow_html=True)

def move_N(nosnos):
    moves_Nd = f"""
        <div style="display: flex; justify-content: flex-end; align-items: center;">
            <div style="width: fit-content; border: 3px solid lightgray; border-radius: 8px; padding: 0px 12px; test-align: center; background-color: whitesmoke;">
                <span style=" color: dimgray;font-size: 32px; font-weight: bold;">{st.session_state.Cerberus}</span>
            </div>
        </div>
        """
    nosnos.markdown(moves_Nd, unsafe_allow_html=True)

def karikari():
    vol = []
    js = 0
    for kuri in st.session_state.cm:
        if kuri[0] == 0 or kuri[0] == 20:
            vol.append("U")
        if kuri[0] == 1 or kuri[0] == 21:
            vol.append("F")
        if kuri[0] == 2 or kuri[0] == 22:
            vol.append("R")
        if kuri[0] == 3 or kuri[0] == 23:
            vol.append("B")
        if kuri[0] == 4 or kuri[0] == 24:
            vol.append("L")
        if kuri[0] == 5 or kuri[0] == 25:
            vol.append("D")
        if kuri[0] == 10:
            vol.append("x")
        if kuri[0] == 11:
            vol.append("y")
        if kuri[0] == 12:
            vol.append("z")
        if kuri[0] == 13:
            vol.append("m")
        if kuri[0] == 14:
            vol.append("e")
        if kuri[0] == 15:
            vol.append("s")
        if js == 0:
            st.session_state.Cerberus = vol[-1]
        if kuri[0] >= 20:
            vol.append("w")
            if js == 0:
                st.session_state.Cerberus += "w"
        if kuri[1] == 2:
            vol.append("2")
            if js == 0:
                st.session_state.Cerberus += "2"
        if kuri[1] == 3:
            vol.append("'")
            if js == 0:
                st.session_state.Cerberus += "'"
        vol.append(",")
        js = 1
    if len(vol) != 0:
        vol.pop()
    vas = ''.join(vol)
    st.session_state.val = vas

def kakikomi():
    mozimozi = [char for char in st.session_state.val if char.lower() in "UFRBLDxyzmeswufrbldXYZMESW123'"]
    taiki = 0
    st.session_state.cm = []
    for mozi in mozimozi:
        if mozi == "U":
            taiki = 2
            st.session_state.cm.append([0,1])
        if mozi == "F":
            taiki = 2
            st.session_state.cm.append([1,1])
        if mozi == "R":
            taiki = 2
            st.session_state.cm.append([2,1])
        if mozi == "B":
            taiki = 2
            st.session_state.cm.append([3,1])
        if mozi == "L":
            taiki = 2
            st.session_state.cm.append([4,1])
        if mozi == "D":
            taiki = 2
            st.session_state.cm.append([5,1])
        if mozi == "x" or mozi == 'X':
            taiki = 1
            st.session_state.cm.append([10,1])
        if mozi == "y" or mozi == 'Y':
            taiki = 1
            st.session_state.cm.append([11,1])
        if mozi == "z" or mozi == 'Z':
            taiki = 1
            st.session_state.cm.append([12,1])
        if mozi == "m" or mozi == 'M':
            taiki = 1
            st.session_state.cm.append([13,1])
        if mozi == "e" or mozi == 'E':
            taiki = 1
            st.session_state.cm.append([14,1])
        if mozi == "s" or mozi == 'S':
            taiki = 1
            st.session_state.cm.append([15,1])
        if mozi == "u":
            taiki = 1
            st.session_state.cm.append([20,1])
        if mozi == "f":
            taiki = 1
            st.session_state.cm.append([21,1])
        if mozi == "r":
            taiki = 1
            st.session_state.cm.append([22,1])
        if mozi == "b":
            taiki = 1
            st.session_state.cm.append([23,1])
        if mozi == "l":
            taiki = 1
            st.session_state.cm.append([24,1])
        if mozi == "d":
            taiki = 1
            st.session_state.cm.append([25,1])
        if taiki == 2 and (mozi == "w" or mozi == 'W') and len(st.session_state.cm) != 0:
            taiki = 1
            st.session_state.cm[-1][0] += 20
        if (taiki == 2 or taiki == 1) and (mozi == "'" or mozi == '3' or mozi == '2' or mozi == '1') and len(st.session_state.cm) != 0:
            taiki = 0
            if mozi == "1":
                st.session_state.cm[-1][1] = 1
            if mozi == "2":
                st.session_state.cm[-1][1] = 2
            if mozi == "3" or mozi == "'":
                st.session_state.cm[-1][1] = 3

def gnu_seisei():
    #データ書き込み
    with open("datitic.txt", "w") as f:
        f.write(f"com = {st.session_state.cm[0][0]}\n")
        f.write(f"nsa = {st.session_state.cm[0][1]}\n")
        for jj in range(6):
            ngdsao = "["
            ngdsao += f"{st.session_state.con[jj]}"
            for jksd in range(8):
                ngdsao += f",{st.session_state.i[jj][jksd]}"
            ngdsao += "]"
            f.write(f"array ii{jj}[9] = {ngdsao}\n")

def gra_saisei(aslkh):
    if aslkh == 1:
        img = Image.open("test6.gif")
        frame_count = img.n_frames
        kaisi = 0
    elif aslkh == 0:
        img = Image.open("zyunbi.png")
        frame_count = 1
        kaisi = 0
    elif aslkh == 2:
        img = Image.open("test6.gif")
        frame_count = 31
        kaisi = 30
    imdg = []
    for j in range(kaisi, frame_count):
        img.seek(j)#指定したフレームに移動
        buffered = BytesIO()
        imdgfs = img.convert("RGBA").save(buffered, format="PNG")
        imdg.append(base64.b64encode(buffered.getvalue()).decode())
    width, height = img.size
    js_frames = json.dumps(imdg)
    canvas_html = f"""
    <div id="wrapper" style="width: 100%;">
        <canvas id="canvas" style="width: 100%; border:1px solid #000;"></canvas>
    </div>
    <script>
        const frames = {js_frames};
        const wrapper = document.getElementById('wrapper');
        const canvas = document.getElementById("canvas");
        const ctx = canvas.getContext("2d");
        const loadedFrames = [];
        let loaded = 0;
        for (let i = 0; i < frames.length; i++) {{
            const img = new Image();
            img.onload = () => {{
                loaded++;
                if (loaded === frames.length) {{
                    const displayWidth = wrapper.clientWidth;
                    const scale = displayWidth / img.width;
                    const displayHeight = img.height * scale;
                    canvas.width = displayWidth;
                    canvas.height = displayHeight;
                    startAnimation(displayWidth, displayHeight);
                }}
            }};
            img.src = "data:image/png;base64," + frames[i];
            loadedFrames.push(img);
        }}
        function startAnimation(displayWidth, displayHeight) {{
            canvas.width = loadedFrames[0].width;
            canvas.height = loadedFrames[0].height;
            let index = 0;
            function draw() {{
                if (index >= loadedFrames.length) {{
                    return;
                }}
                ctx.clearRect(0, 0, displayWidth, displayHeight);
                ctx.drawImage(loadedFrames[index], 0, 0);
                index++;
                setTimeout(draw, 100);
            }}
            draw();
        }}
    </script>
    """
    with placeholder:
        components.html(canvas_html, height=height+50)

sasakusei()
with st.container(horizontal_alignment="center"):
    placeholder = st.empty()#グラフ表示場所
gra_saisei(0)
st.write("")
st.write("Available command:　U, F, R, B, L, D,　x, y, z,　m, e, s,　Uw, Fw, Rw, Bw, Lw, Dw,　or each + {'} , {2}")
