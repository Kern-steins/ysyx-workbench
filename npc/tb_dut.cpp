#include <stdlib.h>
#include <iostream>
#include <cstdlib>
#include <memory>
#include <verilated.h>
#include <verilated_vcd_c.h>

#include "Vdut.h"
//#include "Vdut___024unit.h"
//TIME_REFER表示每次跑基数，1000_000为us
#define TIME_REFER 1000
//MAX_TIME表示要跑多少，例如100就是100us
#define MAX_TIME 1
#define MAX_SIM_TIME ((MAX_TIME)*(TIME_REFER)) 
#define VERIF_START_TIME 7

vluint64_t sim_time = 0;
vluint64_t posedge_cnt = 0;

class dut_in_tx
{
public:
	uint32_t in_clk;
	//3_gpio
	uint32_t gpio_in_1;
	uint32_t gpio_in_2;
	uint32_t gpio_in_3;
	uint32_t exp_res();

};

uint32_t dut_in_tx::exp_res(){

	return 0;
}


class dut_out_tx
{
public:
	uint32_t gpio_out_1;
	uint32_t gpio_out_2;
	uint32_t led;
	uint32_t VGA_R;
	uint32_t VGA_G;
	uint32_t VGA_B;
	uint32_t seg0;
	uint32_t seg1;
	uint32_t seg2;
	uint32_t seg3;
	uint32_t seg4;
	uint32_t seg5;
	uint32_t seg6;
	uint32_t seg7;
	uint32_t rel_res();

};

uint32_t dut_out_tx::rel_res(){

	return 0;
}


class dut_scb
{
private:
	// 定义了一个输入FIFO，用于以FIFO形式储存输入的变量
	std::deque<dut_in_tx *> in_fifo;

public:
	// 将输入的数据写入FIFO和检测写出FIFO
	void write_in(dut_in_tx *tx)
	{
		in_fifo.push_back(tx);
	}
	void write_out(dut_out_tx *tx)
	{
		if (in_fifo.empty())
		{
			std::cout << "Fatal Error in dut_scb: "
					  << "empty dut_in_tx queue" << std::endl;
			exit(1);
		}

		dut_in_tx *in;
		in = in_fifo.front();
		in_fifo.pop_front(); 

		if (in->exp_res() != tx->rel_res()){
			/* code */
		}


   		delete in;
		delete tx;
	}
};

class dut_in_drv
{
private:
	Vdut *dut;

public:
	dut_in_drv(Vdut *dut)
	{
		this->dut = dut;
	}

	void drive(dut_in_tx *tx)
	{
        dut->in_valid = 0;

		// 默认为输入为无效输入
		// 当Transacter给出一个Transaction且操作数并不为空时
		// 认为当前输入为有效输入，in_valid置1
		// 下方函数功能为：将FIFO输入与实例DUT的接口连接
		if (tx != NULL){
			dut->in_clk = tx->in_clk;
			dut->gpio_in_1 = tx->gpio_in_1;
			dut->gpio_in_2 = tx->gpio_in_2;
			dut->gpio_in_3 = tx->gpio_in_3;
			dut->in_valid = 1;
		}		
		delete tx;
	}
};

class dut_in_mon
{
private:
	Vdut *dut;
	dut_scb *scb;

public:
	dut_in_mon(Vdut *dut, dut_scb *scb)
	{
		this->dut = dut;
		this->scb = scb;
	}

	void monitor()
	{
        if (dut->in_valid == 1){
    		// 当驱动函数认为接收到了有效输入后, 创建一个transaction
    		// 并将驱动函数的输出存储并传递给scoreboard
    		// 下方函数功能为：将in_FIFO输入赋值到Monitor中
    		dut_in_tx *tx = new dut_in_tx();
    		tx->in_clk = dut->in_clk;
    		tx->gpio_in_1 = dut->gpio_in_1;
    		tx->gpio_in_2 = dut->gpio_in_2;
    		tx->gpio_in_3 = dut->gpio_in_3;

    		scb->write_in(tx);
	    }
	}
};

class dut_out_mon
{
private:
	Vdut *dut;
	dut_scb *scb;

public:
	dut_out_mon(Vdut *dut, dut_scb *scb)
	{
		this->dut = dut;
		this->scb = scb;
	}

	void monitor()
	{
        if(dut->out_valid == 1){
	    	// 当驱动函数认为接收到了有效输出后, 创建一个transaction
	    	// 并将驱动函数的输出存储并传递给scoreboard
	    	// 下方函数功能为：将out_FIFO输入赋值到Monitor中
	    	dut_out_tx *tx = new dut_out_tx();
	    	tx->gpio_out_1 = dut->gpio_out_1;
	    	tx->gpio_out_2 = dut->gpio_out_2;
	    	tx->led	= dut->led;
	    	tx->VGA_R = dut->VGA_R;
	    	tx->VGA_G = dut->VGA_G;
	    	tx->VGA_B = dut->VGA_B;
	    	tx->seg0 = dut->seg0;
	    	tx->seg1 = dut->seg1;
	    	tx->seg2 = dut->seg2;
	    	tx->seg3 = dut->seg3;
	    	tx->seg4 = dut->seg4;
	    	tx->seg5 = dut->seg5;
	    	tx->seg6 = dut->seg6;
	    	tx->seg7 = dut->seg7;

	    	scb->write_out(tx);
        }
	}
};

void dut_reset(Vdut* dut, vluint64_t &sim_time)
{   
    dut->rst = 0;
    if (sim_time > VERIF_START_TIME && sim_time < VERIF_START_TIME + 3){
       dut->rst = 1;
       dut->in_valid = 0;
       dut->in_clk = 0;
       dut->gpio_in_1 = 0;
       dut->gpio_in_2 = 0;
       dut->gpio_in_3 = 0;

    }
    
}

dut_in_tx* rnd_in_tx(){
	if ( rand()%10 == 0 ){
		dut_in_tx *tx = new dut_in_tx();



		return tx;
	} else return NULL;
}

int main(int argc, char const *argv[])
{
	srand(time(NULL));
	Verilated::commandArgs(argc, argv);
	Vdut *dut = new Vdut;

	Verilated::traceEverOn(true);
	VerilatedVcdC *m_trace = new VerilatedVcdC;
	dut->trace(m_trace, 5);
	m_trace->open("waveform.vcd");

	dut_in_tx *tx;

	// Here we create the driver, scoreboard, input and output monitor blocks
	dut_in_drv *drv = new dut_in_drv(dut);
	dut_scb *scb = new dut_scb();
	dut_in_mon *inMon = new dut_in_mon(dut, scb);
	dut_out_mon *outMon = new dut_out_mon(dut, scb);

	while (sim_time < MAX_SIM_TIME){
		dut_reset(dut, sim_time);
		dut->clk ^= 1;
		dut->eval();

		// Do all the driving/monitoring on a positive edge
		if (dut->clk == 1)
		{

			if (sim_time >= VERIF_START_TIME)
			{
				// Generate a randomised transaction item of type dutInTx
				tx = rnd_in_tx();

				// Pass the transaction item to the dut input interface driver,
				// which drives the input interface based on the info in the
				// transaction item
				drv->drive(tx);

				// Monitor the input interface
				inMon->monitor();

				// Monitor the output interface
				outMon->monitor();
			}
            posedge_cnt++;
		}
		// end of positive edge processing

		m_trace->dump(sim_time);
		sim_time++;
	}

	m_trace->close();
	delete dut;
	delete outMon;
	delete inMon;
	delete scb;
	delete drv;
	exit(EXIT_SUCCESS);
}
