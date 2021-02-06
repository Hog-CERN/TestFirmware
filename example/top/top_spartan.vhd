library IEEE, spartan;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;

entity spartan_top is
Generic (
  constant DATA_WIDTH  : positive := 16;
  constant FIFO_DEPTH	: positive := 256;
    -- Global Generic Variables
    GLOBAL_DATE : std_logic_vector(31 downto 0) := (others => '0');
    GLOBAL_TIME : std_logic_vector(31 downto 0) := (others => '0');
    GLOBAL_VER  : std_logic_vector(31 downto 0) := (others => '0');
    GLOBAL_SHA  : std_logic_vector(31 downto 0) := (others => '0');
    TOP_VER     : std_logic_vector(31 downto 0) := (others => '0');
    TOP_SHA     : std_logic_vector(31 downto 0) := (others => '0');
    CON_VER     : std_logic_vector(31 downto 0) := (others => '0');
    CON_SHA     : std_logic_vector(31 downto 0) := (others => '0');
    HOG_VER     : std_logic_vector(31 downto 0) := (others => '0');
    HOG_SHA     : std_logic_vector(31 downto 0) := (others => '0');    
    
    --IPBus XML
    XML_SHA : std_logic_vector(31 downto 0) := (others => '0');
    XML_VER : std_logic_vector(31 downto 0) := (others => '0');
    
    -- Project Specific Lists (One for each .src file in your Top/myproj/list folder)
    SPARTAN_VER : std_logic_vector(31 downto 0) := (others => '0');
    SPARTAN_SHA : std_logic_vector(31 downto 0) := (others => '0');
   
    -- Project flavour
    FLAVOUR      : integer := 0
  );
Port ( 
  ck40_p	: in  STD_LOGIC;
  ck40_n	: in  STD_LOGIC;
  RST		: in  STD_LOGIC;
  vme_data  : out STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0)
  );
end spartan_top;

architecture Behavioral of spartan_top is
signal clK_i : std_logic;
signal adder_in : std_logic_vector(DATA_WIDTH-1 downto 0) := (others => '1');
signal adder_out : std_logic_vector(DATA_WIDTH-1 downto 0) := (others => '0');



component clock_gen
        port(                           -- Clock in ports
            CLK_IN1_P         : in     std_logic;
            CLK_IN1_N         : in     std_logic;
            --CLK_IN1  : in  std_logic;
            --- Clock out ports
            CLK_OUT1 : out std_logic;
            -- Status and control signals
            RESET    : in  std_logic;
            LOCKED   : out std_logic
        );
    end component;

begin


vme_data <= adder_out;

clock_gen_instance : clock_gen
port map(
    CLK_IN1_P  => ck40_p,
    CLK_IN1_N  => ck40_n,
    CLK_OUT1 => clK_i,
    RESET    => RST,
    LOCKED   => open
);

adder : entity spartan.adder
generic map(
   DATA_WIDTH => DATA_WIDTH
   )
port map(
    clk => clk_i,
    DataIn => adder_in,
    DataOut => adder_out
    );




end Behavioral;
