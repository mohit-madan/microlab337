-- A Mealy machine has outputs that depend on both the state and
-- the inputs.	When the inputs change, the outputs are updated
-- immediately, without waiting for a clock edge.  The outputs
-- can be written more than once per state or per clock cycle.

library ieee;
use ieee.std_logic_1164.all;

entity mealy_4s is

	port
	(
		clk		 : in	std_logic;
		opcode	 : in	std_logic_vector(3 downto 0);
		type : in std_lo
		reset	 : in	std_logic;
		carry,zero,valid: in std_logic;
		data_out : out	std_logic_vector(1 downto 0)
	);
	
end entity;

architecture rtl of mealy_4s is

	-- Build an enumerated type for the state machine
	type state_type is (s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15, s16, s17, s18, s19);
	
	-- Register to hold the current state
	signal state : state_type;

begin
	process (clk, reset)
	begin
		if reset = '1' then
			state <= s1;
		elsif (rising_edge(clk)) then
			-- Determine the next state synchronously, based on
			-- the current state and the input
			case state is
				when s1=>
					if (opcode = '0000') and ((type = '01' and zero = '0') or (type = '10' and carry = '0')) then
						state <= s5;
					else if opcode = '0010' and ((type = '10' and carry = '0') or (type = '01' and zero = '0')) then
						state <= s5;
					else if opcode = '0011' then
						state <= s9;
					else if opcode = '1000' then
						state <= s18;
					else if opcode = '1001' then
						state <= s13;
					else
						state <= s2;
					end if;
					
				when s2=>
					if opcode = '0001' or opcode = '0100' then
						state <= s7;
					else if opcode = '0110' or opcode = '0111' then					then
						state <= s8;
					else 
						state <= s3;
					end if;
				
				when s3=>
					if opcode = '0100' then
						state <= s12;
					if opcode = '1100' then
						if zero = '0' then
							state <= s5;
						else 
							state <= s17;
					else
						state <= s4;
				
				when s4 =>
					state <= s5;
				
				when s5 =>
					state <= s1;
					
				when s6 =>
					state <= s1;
				
				when s7 =>
					if opcode = '0001' then
						state <= s4;
					else if opcode = '0100' then	
						state <= s11;
					else if opcode = '0101' then
						state <= s14;
					end if;
					
				when s8 =>
					if ((opcode = '0110') or (opcode = '0111')) 
						if valid = '0' then
							state <= s5;
						else
							state <= s10;
					end if;
					
				when s9 =>
					state <= s5;
				
				when s10 =>
					if opcode = '0110' then
						state <= s8;
					else if opcode = '0111' then
						state <= s15;
					end if;
					
				when s11 =>
					state <= s3;
					
				when s12 =>
					state <= s5;
					
				when s13 =>
					state <= s6;
					
				when s15 =>
					state <= s16;
					
				when s16 =>
					state <= s8;
				
				when s17 =>
					state <= s5;
					
				when s18 =>
					state <= s19;
				
				when s19 =>
					state <= s1;
									
			end case;
			
		end if;
	end process;
	
	-- Determine the output based only on the current state
	-- and the input (do not wait for a clock edge).
	process (state, data_in)
	begin
		case state is
			when s0=>
				if data_in = '1' then
					data_out <= "00";
				else
					data_out <= "01";
				end if;
			when s1=>
				if data_in = '1' then
					data_out <= "01";
				else
					data_out <= "11";
				end if;
			when s2=>
				if data_in = '1' then
					data_out <= "10";
				else
					data_out <= "10";
				end if;
			when s3=>
				if data_in = '1' then
					data_out <= "11";
				else
					data_out <= "10";
				end if;
		end case;
	end process;
	
end rtl;