----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2019/09/05 15:58:33
-- Design Name: 
-- Module Name: choose_end_line - Behavioral
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

entity choose_end_line is
  Port (clk,up,down,confirm:in std_logic;
        --end_line:out std_logic_vector(3 downto 0) 
        end_line:out integer range 4 downto 1
        );
end choose_end_line;

architecture Behavioral of choose_end_line is
--signal sig_end_line:integer range 4 downto 1;--���ź�sig_end_line�����һ��1~4������
begin
choosing:process(clk,up,down,confirm)
variable temp:integer range 4 downto 1;--�ѱ���starting_line�����һ��1~4�����������������Ҫ��Ϊ���ڽ�����ʵʱ������·��ֵ
begin
temp:=1;
if (clk'event and clk='1') then 
if (up='1') then temp:=temp+1;end if;
if (down='1') then temp:=temp-1;end if;
if (confirm='1') then end_line<=temp;end if;
end if;
--end_line<=conv_std_logic_vector(sig_end_line,4);--����·��1��2��3��4ת����4λ��������
end process choosing;

end Behavioral;
