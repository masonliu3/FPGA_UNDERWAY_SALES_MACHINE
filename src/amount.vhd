----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2019/09/11 20:46:42
-- Design Name: 
-- Module Name: amount - Behavioral
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

entity amount is
  Port (clk,up,down,confirm:in std_logic; 
        ticket_amount:out std_logic_vector(31 downto 0);
        get_present_state:in std_logic_vector(3 downto 0);
        int_amount:out integer
        --dispdata :out std_logic_vector(31 downto 0)
        );
end amount;

architecture Behavioral of amount is
signal sig_amount:integer range 3 downto 1;--���ź�sig_starting_line�����һ��1~4������
signal sig_amount32:std_logic_vector(31 downto 0);
signal confirm0,up0,down0:std_logic;
--signal tem:integer range 3 downto 1;
begin

process(clk)
begin
if (clk'event and clk='1') then
    sig_amount32<=conv_std_logic_vector(sig_amount,32);
    int_amount<=sig_amount;
    confirm0<=confirm;
    up0<=up;
    down0<=down;
    ticket_amount<=sig_amount32;
end if;
end process;

process(clk,up,down,confirm,get_present_state)
variable temp:integer range 3 downto 1:=1;--�ѱ���starting_line�����һ��1~4�����������������Ҫ��Ϊ���ڽ�����ʵʱ������·��ֵ
begin

if (clk'event and clk='1') then 
if (get_present_state="0000") then
temp:=1;sig_amount<=temp;
end if;
if (get_present_state="0110") then
if (up='1'and up0='0') then temp:=temp+1;sig_amount<=temp;end if;
if (down='1'and down0='0') then temp:=temp-1;sig_amount<=temp;end if;
--if (confirm='1'and confirm0='0') then tem<=temp;end if;
end if;
end if;
--sig_amount<=conv_std_logic_vector(tem,32);
--sig_amount32<=conv_std_logic_vector(tem,32);
--dispdata<=sig_amount32; --��ʾ��������32λ2������
--starting_line<=conv_std_logic_vector(sig_starting_line,4);--����·��1��2��3��4ת����4λ��������
end process;

end Behavioral;
