library IEEE, example;
library other_lib;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

entity top_example is
Generic (
  constant DATA_WIDTH  : positive := 16;
  constant FIFO_DEPTH	: positive := 256
  );
Port ( 
  CLK		: in  STD_LOGIC;
  RST		: in  STD_LOGIC;
  WriteEn	: in  STD_LOGIC;
  DataIn	: in  STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
  ReadEn	: in  STD_LOGIC;
  DataOut	: out STD_LOGIC_VECTOR (DATA_WIDTH - 1 downto 0);
  Empty	: out STD_LOGIC;
  Full	: out STD_LOGIC
  );
end top_example;

architecture Behavioral of top_example is
signal fifo_out : std_logic_vector(DATA_WIDTH-1 downto 0) := (others => '0');
signal adder_out : std_logic_vector(DATA_WIDTH-1 downto 0) := (others => '0');

COMPONENT fifo_generator_1
  PORT (
    clk : IN STD_LOGIC;
    srst : IN STD_LOGIC;
    din : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    wr_en : IN STD_LOGIC;
    rd_en : IN STD_LOGIC;
    dout : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    full : OUT STD_LOGIC;
    empty : OUT STD_LOGIC);
END COMPONENT;

begin

fifo : fifo_generator_1
PORT MAP (
    clk => clk,
    srst => RST,
    din => DataIn,
    wr_en => WriteEn,
    rd_en => ReadEn,
    dout => fifo_out,
    full => Full,
    empty => Empty
    );

adder : entity example.adder
generic map(
   DATA_WIDTH => DATA_WIDTH
   )
port map(
    clk => clk,
    DataIn => fifo_out,
    DataOut => adder_out
    );

adder2 : entity other_lib.different_adder
generic map(
   DATA_WIDTH => DATA_WIDTH
   )
port map(
    clk => clk,
    DataIn => adder_out,
    DataOut => DataOut
    );


end Behavioral;
