library ieee;
use ieee.std_logic_1164.all;
--use ieee.std_logic_textio.all;
library std;
use std.textio.all;

entity Testbench is
end entity;

architecture Behave of Testbench is

    constant num_inputs : integer := 11;
    constant num_outputs : integer := 20;

    signal carry, zero, valid, IR_3_5,IR_7: std_logic;
    signal op_code: std_logic_vector(3 downto 0);
    signal cp_type : std_logic_vector(1 downto 0);

    signal control_store : std_logic_vector(19 downto 0) ;

    signal clk: std_logic := '0';
    signal reset: std_logic := '1';
    signal din: std_logic_vector(num_inputs-1 downto 0);
    signal dout: std_logic_vector(num_outputs-1 downto 0);
    --signal finished: std_logic := '0';
    
    function to_std_logic_vector(x: bit_vector) return std_logic_vector is
      variable ret_val: std_logic_vector(1 to x'length);
      alias lx: bit_vector(1 to x'length) is x;
  begin
    for I in 1 to x'length loop
        if(lx(I) = '1') then
            ret_val(I) := '1';
        else
            ret_val(I) := '0';
        end if;
    end loop;
    return(ret_val);
  end to_std_logic_vector;

  function to_bit_vector(x: std_logic_vector) return bit_vector is
      variable ret_val: bit_vector(1 to x'length);
      alias lx: std_logic_vector(1 to x'length) is x;
  begin
    for I in 1 to x'length loop
        if(lx(I) = '1') then
            ret_val(I) := '1';
        else
            ret_val(I) := '0';
        end if;
    end loop;
    return(ret_val);
  end to_bit_vector;

    component control_path is

    port
    (
        clk             : in    std_logic;
        opcode          : in    std_logic_vector(3 downto 0);
        op_type         : in    std_logic ;
        reset           : in    std_logic;
        carry,zero,valid    : in    std_logic;
        IR_3_5          : in std_logic_vector(2 down to 0) ;
        control_store   : out   std_logic_vector (19 downto 0)
    );
    
end component;

begin
    clk <= not clk after 10 ns; -- assume 20ns clock.
    


    cp: control_path port map(
            op_code => din(10 downto 7),
            op_type => din(6 downto 5),
            carry => din(4),
            zero => din(3),
            valid => din(2),
            IR_3_5 => din(1),
            IR_7 => din(0)

            control_store => dout(19));

    -- reset process
    process
    begin
        wait until clk = '1';
        reset <= '0';
        wait;
    end process;

    process 
        variable err_flag : boolean := false;
        File INFILE: text open read_mode is "TRACEFILE.txt";
        FILE OUTFILE: text  open write_mode is "OUTPUTS.txt";
        
        ---------------------------------------------------
        -- DUT variables
        variable din_var: bit_vector(num_inputs-1 downto 0);
        variable read_var, dout_var: bit_vector(num_outputs-1 downto 0);
        ----------------------------------------------------
        
        

        variable INPUT_LINE: Line;
        variable OUTPUT_LINE: Line;
        variable LINE_COUNT: integer := 0;
        
    begin

        while not endfile(INFILE) loop 
            wait until clk = '0';
            LINE_COUNT := LINE_COUNT + 1;
            readLine (INFILE, INPUT_LINE);
            
            --start the gcd system
            wait until clk='1';
            
            read (INPUT_LINE, din_var);
            din <= to_std_logic_vector(din_var);

            read(INPUT_LINE, read_var);

            wait until clk = '0';
            dout_var := to_bit_vector(dout);

            write(OUTPUT_LINE,dout_var);
            writeline(OUTFILE,OUTPUT_LINE);
            if (read_var /= dout_var) then
                write(OUTPUT_LINE,string'("ERROR: in line "));
                write(OUTPUT_LINE, LINE_COUNT);
                writeline(OUTFILE, OUTPUT_LINE);
                err_flag := true;
            end if;

        end loop;
        
        assert (err_flag) report "SUCCESS, all tests passed." severity note;
        assert (not err_flag) report "FAILURE, some tests failed." severity error;
        
        --finished <= '1';
        wait;
    end process;
	 
	--process(din,dout,start,done,erdy,srdy,clk,reset)
 --       variable scLine: Line;
 --       variable scIn: std_logic_vector(19 downto 0);
 --       FILE scFile: text  open write_mode is "in.txt";
 --   begin
 --       scIn(19) := start;
 --       scIn(18) := erdy;
 --       scIn(17) := reset;
 --       scIn(16) := clk;
 --       scIn(15 downto 0) := din;
        
 --       write(scLine,string'("SDR 20 TDI("));
 --       hwrite(scLine,scIn);
 --       write(scLine,string'(") 16 TDO("));
 --       hwrite(scLine,dout);
        
 --       if(done='1') then
 --           if(clk='1') then
 --               write(scLine,string'(") MASK(FFFF)"));
 --           else
 --               write(scLine,string'(") MASK(0000)"));
 --           end if;
 --       else
 --           write(scLine,string'(") MASK(0000)"));
 --       end if;
        
 --       writeline(scFile, scLine);
 --       write(scLine,string'("RUNTEST 1 MSEC"));
 --       writeline(scFile, scLine);
 --   end process;

 --   dut: System port map(
 --       din => din, dout => dout,
 --       start => start, done => done, erdy => erdy, srdy => srdy,
 --       clk => clk, reset => reset);

end Behave;