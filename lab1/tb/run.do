if [file exists work] {vdel -all}
vlib work
vlog -f files.f
onbreak {resume}
set NoQuitOnFinish 1
#vsim -voptargs=+acc work.tb_Mux
vsim -voptargs=+acc work.tb_Mux 
do wave.do
run 130ms
