module ps2 (
        input clk,  // Clock
        input rst,  // Asynchronous reset active low
        input ps2_clk,
        input ps2_data,
        output logic [7:0] out_1

    );

    logic [10:0] buffer;

    logic [3:0] count;
    logic [3:0] count_r;
    logic [2:0] ps2_clk_sync;
    logic ready;
    logic ready_r;
    logic [7:0] out_1_r;


    wire ps2_clk_neg;

    always_ff @(posedge clk) begin
        ps2_clk_sync <= {ps2_clk_sync[1:0], ps2_clk};
    end

    wire ps2_clk_neg = ps2_clk_sync[2] & ~ps2_clk_sync[1];
    /*
    always @(posedge clk) begin
        if (rst ) begin // reset
            count <= '0;
        end
        else begin
            if (ps2_clk_neg) begin
                if (count == 4'd10) begin
                    if ((buffer[0] == 0) &&  // start bit
                            (ps2_data)       &&  // stop bit
                            (^buffer[9:1])) begin      // odd  parity
                        $display("receive %x", buffer[8:1]);
                        ready <= 1'b1;
                        out_1 <= buffer[8:1];
                    end
                    count <= 0;     // for next
                end
                else begin
                    buffer[count] <= ps2_data;  // store ps2_data
                    count <= count + 3'b1;
                    ready <= 1'b0;
                end
            end
        end
    end
    */
    always_ff @(posedge clk) begin
        if (rst) begin
            buffer <= '0;
            ready  <= '0;
            count  <= '0;
            out_1  <= '0;
        end
        else begin
            buffer[count] <= ps2_data;
            ready <= ready_r;
            count <= count_r;
            out_1 <= out_1_r;
        end
    end

    always_comb begin
        if (ps2_clk_neg) begin
            if (count == 4'd10) begin
                count_r = '0;
                $display("receice %x", buffer[8:1]);
            end
            else begin
                count_r = count + 1;
            end
        end
        else begin
            count_r = count;
        end

        if (    (count == 4'd0) &&
                (buffer[0] == 1'b0) &&
                (^buffer[9:1]) &&
                (ps2_data)) begin
            out_1_r = buffer[8:1];
            ready_r = 1'b1;
        end
        else begin
            out_1_r = '0;
            ready_r = 1'b0;
        end
    end
endmodule :
ps2
