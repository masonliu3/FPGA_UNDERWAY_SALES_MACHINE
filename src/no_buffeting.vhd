----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2019/09/08 20:23:44
-- Design Name: 
-- Module Name: no_buffeting - Behavioral
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

entity no_buffeting is
  Port (clk,up,down,confirm,back:in std_logic; 
        up0,down0,confirm0,back0:out std_logic);--����0�Ķ���ԭ�����ź�,��0������������ź�
end no_buffeting;

architecture Behavioral of no_buffeting is

begin

up_no_buffeting:process(clk,up)
variable count:integer range 0 to 500000; --1MHz��Ӧ1us��100MHz��Ӧ0.01us��������1һ�����壬һ������Լ5ms��Ҳ����100000*5=500000
begin
if (up='0') then
  if (clk'event and clk='1') then
    if count<500000 then count:=count+1;
    else count:=count;
    end if;
    if count<=499999 then up0<='0';
    else up0<='1';
    end if;
  end if;
else count:=0;up0<='0';
end if;
end process up_no_buffeting;

down_no_buffeting:process(clk,down)
variable count:integer range 0 to 500000; --1MHz��Ӧ1us��100MHz��Ӧ0.01us��������1һ�����壬һ������Լ5ms��Ҳ����100000*5=500000
begin
if (down='0') then
  if (clk'event and clk='1') then
    if count<500000 then count:=count+1;
    else count:=count;
    end if;
    if count<=499999 then down0<='0';
    else down0<='1';
    end if;
  end if;
else count:=0;down0<='0';
end if;
end process down_no_buffeting;

confirm_no_buffeting:process(clk,confirm)
variable count:integer range 0 to 500000; --1MHz��Ӧ1us��100MHz��Ӧ0.01us��������1һ�����壬һ������Լ5ms��Ҳ����100000*5=500000
begin
if (confirm='0') then
  if (clk'event and clk='1') then
    if count<500000 then count:=count+1;
    else count:=count;
    end if;
    if count<=499999 then confirm0<='0';
    else confirm0<='1';
    end if;
  end if;
else count:=0;confirm0<='0';
end if;
end process confirm_no_buffeting;

back_no_buffeting:process(clk,back)
variable count:integer range 0 to 500000; --1MHz��Ӧ1us��100MHz��Ӧ0.01us��������1һ�����壬һ������Լ5ms��Ҳ����100000*5=500000
begin
if (back='0') then
  if (clk'event and clk='1') then
    if count<500000 then count:=count+1;
    else count:=count;
    end if;
    if count<=499999 then back0<='0';
    else back0<='1';
    end if;
  end if;
else count:=0;back0<='0';
end if;
end process back_no_buffeting;

--�ĸ������ֱ�����
end Behavioral;
