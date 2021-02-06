library IEEE, example;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity top_proj is
  generic (
    constant DATA_WIDTH : positive := 16;
    constant FIFO_DEPTH : positive := 256
    );
  port (
    CLK     : in  std_logic;
    RST     : in  std_logic;
    WriteEn : in  std_logic;
    DataIn  : in  std_logic_vector (DATA_WIDTH - 1 downto 0);
    ReadEn  : in  std_logic;
    DataOut : out std_logic_vector (DATA_WIDTH - 1 downto 0);
    Empty   : out std_logic;
    Full    : out std_logic
    );
end top_proj;

architecture Behavioral of top_proj is
  signal fifo_out  : std_logic_vector(DATA_WIDTH-1 downto 0) := (others => '0');
  signal adder_out : std_logic_vector(DATA_WIDTH-1 downto 0) := (others => '0');

  component fifo_generator_1
    port (
      clk   : in  std_logic;
      srst  : in  std_logic;
      din   : in  std_logic_vector(15 downto 0);
      wr_en : in  std_logic;
      rd_en : in  std_logic;
      dout  : out std_logic_vector(15 downto 0);
      full  : out std_logic;
      empty : out std_logic);
  end component;

begin
  fifo : fifo_generator_1
    port map (
      clk   => clk,
      srst  => RST,
      din   => DataIn,
      wr_en => WriteEn,
      rd_en => ReadEn,
      dout  => fifo_out,
      full  => Full,
      empty => Empty
      );

  adder : entity example.adder
    generic map(
      DATA_WIDTH => DATA_WIDTH
      )
    port map(
      clk     => clk,
      DataIn  => fifo_out,
      DataOut => adder_out
      );

  adder2 : entity example.different_adder
    generic map(
      DATA_WIDTH => DATA_WIDTH
      )
    port map(
      clk     => clk,
      DataIn  => adder_out,
      DataOut => DataOut
      );


end Behavioral;
