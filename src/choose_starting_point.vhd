----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2019/09/03 15:24:50
-- Design Name: 
-- Module Name: choose_starting_point - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity choose_starting_point is
  Port (clk1,up1,down1,confirm1:in std_logic;
  get_starting_line:in std_logic_vector(1 downto 0);
        --starting_point:out std_logic_vector(4 downto 0)
  starting_point:out std_logic_vector(4 downto 0);
  get_present_state:in std_logic_vector(3 downto 0);
  dispdata :out std_logic_vector(31 downto 0)
        );
end choose_starting_point;

--����һ����27վ��������26վ��������29վ���ĺ���18վ
architecture Behavioral of choose_starting_point is

--����ѡ��ǰ��·��ģ�飬ע��λ�ã���architecture������
--component choose_starting_line
  --Port (clk,up,down,confirm:in std_logic;
        --starting_line:out std_logic_vector(3 downto 0));
--end component;

--signal sig_sl:std_logic_vector(3 downto 0);

--signal sig_starting_1_point:integer range 26 downto 0;--���ź�sig_starting_1_point(��1���ߵ�վ��)�����һ��1~27������
--signal sig_starting_2_point:integer range 25 downto 0;--���ź�sig_starting_2_point(��1���ߵ�վ��)�����һ��1~26������
--signal sig_starting_3_point:integer range 28 downto 0;--���ź�sig_starting_3_point(��1���ߵ�վ��)�����һ��1~29������
--signal sig_starting_4_point:integer range 17 downto 0;--���ź�sig_starting_4_point(��1���ߵ�վ��)�����һ��1~18������
signal confirm10,up10,down10:std_logic;
signal sig_starting_point:integer;
signal starting_point32:std_logic_vector(31 downto 0);

begin

process(clk1)
begin
if (clk1'event and clk1='1') then
    confirm10<=confirm1;
    up10<=up1;
    down10<=down1;
end if;
end process;


--u1:choose_starting_line port map(clk=>clk1,up=>up1,down=>down1,confirm=>confirm1,starting_line=>sig_sl);
choosing:process(clk1,up1,down1,confirm1,get_present_state)
variable temp1:integer range 26 downto 0:=7;
variable temp2:integer range 25 downto 0:=11;
variable temp3:integer range 28 downto 0:=21;
variable temp4:integer range 17 downto 0:=4;
begin
if (get_present_state="0010") then
--temp1:=7;  --����һ����Ĭ�ϳ�ʼվΪ�½ֿ�
--temp2:=11; --����������Ĭ�ϳ�ʼվΪ���й�
--temp3:=21; --����������Ĭ�ϳ�ʼվΪ�Ͼ���
--temp4:=4;  --�����ĺ���Ĭ�ϳ�ʼվΪ������

case get_starting_line is --��ͬ����·
when "00"=>
 if (clk1'event and clk1='1') then
   if (up1='1'and up10='0') then temp1:=temp1+1;end if;
   if (down1='1'and down10='0') then temp1:=temp1-1;end if;
   if (confirm1='1'and confirm10='0') then sig_starting_point<=temp1;end if;
   --starting_point<=conv_std_logic_vector(sig_starting_1_point,5);--������վ��ת����5λ��������
 end if;
 
 when "01"=>
  if (clk1'event and clk1='1') then
    if (up1='1'and up10='0') then temp2:=temp2+1;end if;
    if (down1='1'and down10='0') then temp2:=temp2-1;end if;
    if (confirm1='1'and confirm10='0') then sig_starting_point<=temp2;end if;
    --starting_point<=conv_std_logic_vector(sig_starting_2_point,5);--������վ��ת����5λ��������
  end if;
  
  when "10"=>
    if (clk1'event and clk1='1') then
      if (up1='1'and up10='0') then temp3:=temp3+1;end if;
      if (down1='1'and down10='0') then temp3:=temp3-1;end if;
      if (confirm1='1'and confirm10='0') then sig_starting_point<=temp3;end if;
      --starting_point<=conv_std_logic_vector(sig_starting_3_point,5);--������վ��ת����5λ��������
    end if;
    
    when "11"=>
      if (clk1'event and clk1='1') then
        if (up1='1'and up10='0') then temp4:=temp4+1;end if;
        if (down1='1'and down10='0') then temp2:=temp4-1;end if;
        if (confirm1='1'and confirm10='0') then sig_starting_point<=temp4;end if;
        --starting_point<=conv_std_logic_vector(sig_starting_4_point,5);--������վ��ת����5λ��������
      end if;
      
 end case;
 starting_point<=conv_std_logic_vector(sig_starting_point,5);
 starting_point32<=conv_std_logic_vector(sig_starting_point,32);
 dispdata<=starting_point32; --��ʾ��
end if;
end process choosing;
end Behavioral;
