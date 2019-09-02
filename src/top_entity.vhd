----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2019/09/02 19:08:29
-- Design Name: 
-- Module Name: top_entity - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top_entity is
      Port (clk:IN std_logic;      --ʱ���ź�
            datain:IN std_logic;
            confirm:IN std_logic;  --��ť��ȷ����
            back:IN std_logic;     --��ť�����ء�
            up:IN std_logic;       --��ť����һ��
            down:IN std_logic;     --��ť����һ��
            led1:OUT std_logic;    --�ĸ�LED�ƣ���ʾ1Ԫ��5Ԫ��10Ԫ��20Ԫ
            led2:OUT std_logic;
            led3:OUT std_logic;
            led4:OUT std_logic;
            switch1:IN std_logic;  --�ĸ����أ�Ͷ��1Ԫ��5Ԫ��10Ԫ��20Ԫ
            switch2:IN std_logic;
            switch3:IN std_logic;
            switch4:IN std_logic;
            num1:OUT std_logic_vector(3 downto 0);  --��һ�������ģ��ĵڼ�λ��
            num2:OUT std_logic_vector(3 downto 0);  --�ڶ��������ģ��ĵڼ�λ��
            dig1:OUT std_logic_vector(7 downto 0);  --��һ�������ģ��ľ�������
            dig2:OUT std_logic_vector(7 downto 0)   --�ڶ��������ģ��ľ�������
            );
end top_entity;

architecture Behavioral of top_entity is
type state_type is(s1,s2,s3,s4,s5,s6,s7,s8,s9,s10);  --��ʮ��״̬���ȴ���ѡ��ǰվ��·��ѡ��ǰվվ�㣬ѡƱ�ۣ�ѡĿ��վ��·��ѡĿ��վվ�㣬ѡƱ����Ͷ��״̬������ɹ����˱ҳɹ�
signal presentstate:state_type;
signal nextstate:state_type;
begin

switch_to_next_state:process(clk)  --��һ��process
begin
if (clk'event and clk='1') then
presentstate<=nextstate;
end if;
end process switch_to_next_state;

change_state_mode:process(confirm,back,up,down,presentstate)  --�ڶ���process
begin
case presentstate is
  when s1=>
    if (confirm='1' or back='1' or up='1' or down='1') then
    nextstate<=s2;
    end if;
  when s2=>
    if (confirm='1') then
    nextstate<=s3;
    else if (back='1') then
    nextstate<=s1;
    end if;
  when s3=>
    if (up='1') then nextstate<=s4;
    else if (down='1') then nextstate<=s5;
    else if (back='1') then nextstate<=s2;
    end if;
  when s4=>
    if (confirm='1') then nextstate<=s5;
    else if (back='1') then nextstate<=s3;
    end if;
  
end Behavioral;
