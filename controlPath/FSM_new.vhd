library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity FSM_new is

	port
	(
		clk		 				: in	std_logic;
		opcode					: in	std_logic_vector(3 downto 0);
		op_type 					: in 	std_logic_vector(1 downto 0);
		reset	 					: in	std_logic;
		carry,zero,valid,cmp	: in 	std_logic;
		IR_3_5					: in  std_logic;
		IR_6_8				   : in STD_LOGIC;--these two have been added
		IR_9_11					: in STD_LOGIC;
		IR_7						: in  std_logic;
		control_store 			: out std_logic_vector (19 downto 0)
	);
	
end entity;

architecture rtl of FSM_new is

	-- Build an enumerated op_type for the state machine
	type state_type is (s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15, s16, s17, s18, s19, s20);
	
	-- Register to hold the current state
	signal state, next_state : state_type;

begin

SYNC_PROC : process (clk, reset)
begin
	if (reset = '1') then
			state <= S1;
	elsif rising_edge(clk) then
		state <= next_state;
	end if;
end process;

CONTROL_STORE_DECODE : process (state)
begin
	case state is
				--when s0 =>
					--control_store <= "00000000000000000000" ;
				when s1=>
					control_store <= "10001001001011000111";
					
				when s2=>
					control_store <= "01000000000010011100";
					
				when s3=>
					control_store <= "00000100000011110110";
					
				when s4 =>
					control_store <= "11000000000011000110";	
				
				when s5 =>
					control_store <= "00100000000011000110";	
					
				when s6 =>
					control_store <= "11010000000011010110";	
				
				when s7 =>
					control_store <= "00001100000011110110";	
					
				when s8 =>
					control_store <= "00000010100111101110";	
					
				when s9 =>
					control_store <= "01100000000110000110";	
					
				when s10 =>
					control_store <= "11101010000000010010";	
					
				when s11 =>
					control_store <= "00000001100011001000";	
				
				when s12 =>
					control_store <= "10110000000011000110";

			--	when s12 =>
			--		control_store <= "00010000000011000110";	
					
				when s13 =>
					control_store <= "10100000000011011110";	
					
				when s14 =>
					control_store <= "00100000010011000110";
					
				when s15 =>
					control_store <= "00000001010011000110";
					
				when s16 =>
					control_store <= "00001010000000000110";	
					
				when s17 =>
					control_store <= "00000110000011000111";	
					
				when s18 =>
					control_store <= "10010111000011100110";	
					
				when s19 =>
					control_store <= "01010000000011000110";
					
				when s20 =>
					control_store <= "00110000000001000010";
				when others =>report "unreachable" severity failure;
				
				end case;
			
		
	end process;
	NEXT_STATE_DECODE : process (state, opcode,op_type,carry,zero,valid,cmp, IR_3_5, IR_7, IR_9_11)
begin
	case state is
				--when s0 =>
					--next_state <= s1 ;
				when s1=>
					next_state <= s2 ;
					
				when s2=>

					if ((opcode = "0000") and ((op_type = "01" and zero = '0') or (op_type = "10" and carry = '0'))) then
						next_state <= s5;
					elsif ((opcode = "0001") or (opcode = "0100") or (opcode = "0101")) then
						next_state <= s7;
					elsif ((opcode = "0010") and ((op_type = "10" and carry = '0') or (op_type = "01" and zero = '0'))) then
						next_state <= s5;
					elsif (opcode = "0011") then
						next_state <= s9;
					elsif ((opcode = "0110") or (opcode = "0111")) then
						next_state <= s8;
					elsif (opcode = "0101") then
						next_state <= s7 ;
					elsif (opcode = "1000") then
						next_state <= s18 ;
					elsif (opcode = "1001") then
						next_state <= s13 ;
					else 
						next_state <= s3;
					end if;
				
				when s3=>
					if (opcode = "0100") then
						next_state <= s12	;
					elsif opcode = "1100" then
						if (cmp = '0') then
							next_state <= s5;
						else 
							next_state <= s17;
						end if;	
					else
						next_state <= s4;
						
					end if;	
				
				when s4 =>
					if(IR_3_5 = '0') then--and (opcode /= "0001") then
						next_state <= s1;
					--elsif (IR_6_8 = '0') and (opcode = "0001") then
					--	next_state <= s1;
					else
						next_state <= s5;
				   end if;
					
				when s5 =>	
					next_state <= s1;
					
				when s6 =>
					next_state <= s1;
				
				when s7 =>
					if opcode = "0001" then
						next_state <= s12;
					elsif opcode = "0100" then	
						next_state <= s11;
					elsif opcode = "0101" then
						next_state <= s14;
					else 
						next_state <= s1;
					end if;
					
				when s8 =>
					if (opcode = "0110") then
						if (valid = '0' and IR_7= '1') then
							next_state <= s1;
						elsif (valid ='1') then
							next_state <= s10;
						else
							next_state <= s1;
						end if;	
					elsif (opcode = "0111" and valid = '1') then
							next_state <= s20 ;
					else
						next_state <= s5 ;
					end if;
					
				when s9 =>
					if (IR_9_11 = '0') then
						next_state <= s1 ;
					else
						next_state <= s5;
				   end if;
				when s10 =>
					if opcode = "0110" then
						next_state <= s8;
					elsif opcode = "0111" then
						next_state <= s15;
					else next_state <= s1;	
					end if;
					
				when s11 =>
					next_state <= s3;
				
				when s12 =>
					if(IR_9_11 = '0') then
						next_state <= s1;
					else next_state <=s5;	
					
					end if;
			
--				when s12 =>
--					if (IR_6_8 = '0') then
--						next_state <= s1 ;
--					else
--						next_state <= s5;
--					end if;
				when s13 =>
					next_state <= s6;
				
				when s14 =>
					next_state <= s1;
					
				when s15 =>
					next_state <= s16;
					
				when s16 =>
					next_state <= s8;
				
				when s17 =>
					next_state <= s5;
					
				when s18 =>
					next_state <= s19;
				
				when s19 =>
					next_state <= s1;
				when s20 =>
					next_state <= s15;
				when others => 
					next_state <= s1;
			end case;
			
	end process;
end rtl;