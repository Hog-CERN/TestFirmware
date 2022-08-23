library IEEE, example;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
 
entity adder is
	Generic (
		constant DATA_WIDTH  : positive := 16;
		constant FIFO_DEPTH	: positive := 256
	);
	Port ( 
		CLK		: in  STD_LOGIC;
        DataIn	: in  STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
		DataOut	: out STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0)
	);
end adder;
 
architecture Behavioral of adder is
begin
add_proc : process( clk )
begin
    if rising_edge(clk) then
        DataOut <= std_logic_vector(unsigned(DataIn) + 2);
    end if;
end process ; -- add_proc
  
end Behavioral;
-- Appending text for diff release 
