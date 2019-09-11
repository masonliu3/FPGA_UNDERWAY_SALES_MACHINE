----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2019/09/04 21:40:38
-- Design Name: 
-- Module Name: choose_starting_line - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;--ʹ�ú���conv_std_logic_vector(m,n)��ǰ��

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity choose_starting_line is
  Port (clk,up,down,confirm:in std_logic;
        get_present_state:in std_logic_vector(3 downto 0);
        starting_line:out std_logic_vector(1 downto 0);
        dispdata :in std_logic_vector(31 downto 0);
        seg_able :in std_logic_vector(7 downto 0);
        segg :out std_logic_vector(7 downto 0);
        an :out std_logic_vector(7 downto 0)
        );
end choose_starting_line;

architecture Behavioral of choose_starting_line is

signal sig_starting_line:integer range 3 downto 0;--���ź�sig_starting_line�����һ��1~4������
signal starting_line32:std_logic_vector(31 downto 0);
signal confirm0,up0,down0:std_logic;

component seven_segment_disp_0
port
 (
    clk :in std_logic;
    dispdata :in std_logic_vector(31 downto 0);
    seg_able :in std_logic_vector(7 downto 0);
    segg :out std_logic_vector(7 downto 0);
    an :out std_logic_vector(7 downto 0)
 );
end component;
signal disp_data_2 : std_logic_vector(31 downto 0);
signal seg_able_2 : std_logic_vector( 7 downto 0);
begin

seg_able_2 <= "11111111"; 

segment_disp_0 : seven_segment_disp_0
port map(
        clk => clk,
        dispdata =>  disp_data_2,
        seg_able =>  seg_able_2,
        segg => segg,
        an => an  
);

process(clk)
begin
if (clk'event and clk='1') then
    confirm0<=confirm;
    up0<=up;
    down0<=down;
end if;
end process;

choosing:process(clk,up,down,confirm,get_present_state)
variable temp:integer range 3 downto 0:=0;--�ѱ���starting_line�����һ��1~4�����������������Ҫ��Ϊ���ڽ�����ʵʱ������·��ֵ
begin

if (clk'event and clk='1') then 
if (get_present_state="0001") then
if (up='1'and up0='0') then temp:=temp+1;end if;
if (down='1'and down0='0') then temp:=temp-1;end if;
if (confirm='1'and confirm0='0') then sig_starting_line<=temp;end if;
end if;
end if;
starting_line<=conv_std_logic_vector(sig_starting_line,2);
starting_line32<=conv_std_logic_vector(sig_starting_line,32);
disp_data_2<=starting_line32; --��ʾ��������32λ2������
--starting_line<=conv_std_logic_vector(sig_starting_line,4);--����·��1��2��3��4ת����4λ��������
end process choosing;
end Behavioral;
