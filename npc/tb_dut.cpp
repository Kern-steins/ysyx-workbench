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
	uint32_t in_1;
	uint32_t in_2;
	uint32_t in_3;
	uint32_t in_4;
	enum operation_t {
		chose_in_1 = 0,
		chose_in_2 = 1,
		chose_in_3 = 2,
		chose_in_4 = 3
	}op;

};

class dut_out_tx
{
public:
	uint32_t out_1;

};

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

		// 检测预期输出和实际输出时候相符
		// 下方函数功能为：将in_monitor和out_monitor的值相比较，看是否符合预期
		switch(in->op){
			case dut_in_tx::chose_in_1 :
				if (in->in_1 != tx->out_1){
                    std::cout << std::endl;
                    std::cout << "MUX: channel_1 mismatch" << std::endl;
                    std::cout << "  Expected: " <<  in->in_1
                    << "  Actual: " << tx->out_1 << std::endl;
                    std::cout << "  Simtime: " << sim_time << std::endl;
			}
			case dut_in_tx::chose_in_2 :
				if (in->in_2 != tx->out_1){
                    std::cout << std::endl;
                    std::cout << "MUX: channel_2 mismatch" << std::endl;
                    std::cout << "  Expected: " << in->in_2
                    << "  Actual: " << tx->out_1 << std::endl;
                    std::cout << "  Simtime: " << sim_time << std::endl;
			}
			case dut_in_tx::chose_in_3 :
				if (in->in_3 != tx->out_1){
                    std::cout << std::endl;
                    std::cout << "MUX: channel_3 mismatch" << std::endl;
                    std::cout << "  Expected: " << in->in_3
                    << "  Actual: " << tx->out_1 << std::endl;
                    std::cout << "  Simtime: " << sim_time << std::endl;
			}
			case dut_in_tx::chose_in_4 :
				if (in->in_4 != tx->out_1){
                    std::cout << std::endl;
                    std::cout << "MUX: channel_4 mismatch" << std::endl;
                    std::cout << "  Expected: " << in->in_4
                    << "  Actual: " << tx->out_1 << std::endl;
                    std::cout << "  Simtime: " << sim_time << std::endl;
			}
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
		// 默认为输入为无效输入
		// 当Transacter给出一个Transaction且操作数并不为空时
		// 认为当前输入为有效输入，in_valid置1
		// 下方函数功能为：将FIFO输入与实例DUT的接口连接
		if (tx != NULL){
			dut->in_1 = tx->in_1;
			dut->in_2 = tx->in_2;
			dut->in_3 = tx->in_3;
			dut->in_4 = tx->in_4;
			dut->op = tx->op;
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
		// 当驱动函数认为接收到了有效输入后, 创建一个transaction
		// 并将驱动函数的输出存储并传递给scoreboard
		// 下方函数功能为：将in_FIFO输入赋值到Monitor中
		dut_in_tx *tx = new dut_in_tx();
		tx->op = dut_in_tx::operation_t(dut->op);
		tx->in_1 = dut->in_1;
		tx->in_2 = dut->in_2;
		tx->in_3 = dut->in_3;
		tx->in_4 = dut->in_4;
	
		scb->write_in(tx);
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
		// 当驱动函数认为接收到了有效输出后, 创建一个transaction
		// 并将驱动函数的输出存储并传递给scoreboard
		// 下方函数功能为：将out_FIFO输入赋值到Monitor中
		dut_out_tx *tx = new dut_out_tx();
		tx->out_1 = dut->out_1;

		scb->write_out(tx);
	}
};

void dut_reset(Vdut* dut, vluint64_t &sim_time)
{   
    dut->rst = 0;
    if (sim_time > VERIF_START_TIME && sim_time < VERIF_START_TIME + 3){
       dut->rst = 1;
       dut->in_1 = 0;
       dut->in_2 = 0;
       dut->in_3 = 0;
       dut->in_4 = 0;
       dut->op = 0;
    }
    
}

dut_in_tx* rnd_in_tx(){
	if ( rand()%5 == 0 ){
		dut_in_tx *tx = new dut_in_tx();
		tx->op = dut_in_tx::operation_t( rand()%4 );
		tx->in_1 = rand() % 4;
		tx->in_2 = rand() % 4;
		tx->in_3 = rand() % 4;
		tx->in_4 = rand() % 4;
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
