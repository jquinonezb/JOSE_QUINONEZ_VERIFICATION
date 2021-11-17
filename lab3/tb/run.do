if [file exists work] {vdel -all}
vlib work
#vlog +define+pos_reset +define+info -f files.f
vlog +define+ -f files.f
onbreak {resume}
set NoQuitOnFinish 1
vsim -voptargs=+acc work.TB_FFD
do wave.do
run 1300ps
