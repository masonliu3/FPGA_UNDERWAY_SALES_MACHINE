library IEEE;
use IEEE.STD_LOGIC_1164.ALL;--����ʹ��STD_LOGIC,STD_LOGIC_VECTOR
use IEEE.STD_LOGIC_ARITH.ALL;--��������ת��
use IEEE.STD_LOGIC_UNSIGNED.All;--��������ת��

entity top_entity is
    Port(
            clk:IN std_logic;      --ʱ���ź�
            confirm:IN std_logic;  --��ť"ȷ��"
            back:IN std_logic;     --��ť"����"
            up:IN std_logic;       --��ť"��һ"
            down:IN std_logic;     --��ť"��һ"
            led0:OUT std_logic;    --�ĸ�LED�ƣ���ʾ1Ԫ��5Ԫ��10Ԫ��20Ԫ
            led1:OUT std_logic; 
            led2:OUT std_logic; 
            led3:OUT std_logic; 
            led4:OUT std_logic; 
            led5:OUT std_logic; 
            led6:OUT std_logic; 
            led7:OUT std_logic; 
            led8:OUT std_logic; 
            led9:OUT std_logic; 
            get_total,get_ticket_price:IN std_logic_vector(31 downto 0);    
            get_real_pay:IN std_logic_vector(31 downto 0);         
            --switch0:IN std_logic;  --�ĸ����أ�Ͷ��1Ԫ��5Ԫ��10Ԫ��20Ԫ
            --switch1:IN std_logic;
            --switch2:IN std_logic;
            --switch3:IN std_logic;
            --num:OUT std_logic_vector( 7 downto 0 );  --�����ģ��ĵڼ�λ��
            --dig:OUT std_logic_vector( 7 downto 0 );  --�����ģ��ľ���ܽ�
            get_up_to_5sec,get_flag0:IN std_logic;
            status:out std_logic_vector(3 downto 0)
        );    
end top_entity;

architecture Behavioral of top_entity is
signal flag:std_logic;
signal present_state:std_logic_vector(3 downto 0);
signal confirm0,back0,up0,down0:std_logic;

begin

process(clk)
begin
if (clk'event and clk='1') then
    status<=present_state;
    confirm0<=confirm;
    back0<=back;
    up0<=up;
    down0<=up;
end if;
end process;


process(clk,confirm,back,up,down,present_state)  

begin
if (clk'event and clk='1') then

case present_state is

  when "0000"=>  --s1�ȴ�״̬
  
    if (confirm0='0' and confirm='1') then  --��ȷ�Ͻ���ѡ��ʼ��״̬
    present_state<="0001";
    end if;

  when "0001"=>  --ѡ��ǰվ��·״̬
    
    if (confirm0='0' and confirm='1') then present_state<="0010";end if;
    if (back0='0' and back='1') then present_state<="0000";end if;

  when "0010"=>  --ѡ��ǰվվ��״̬
    
   -- if (up0='0' and up='1') then present_state<="0011";end if; --�����ϡ�����ѡƱ��״̬
    if (confirm0='0' and confirm='1') then present_state<="1010";end if;  --��ȷ������״̬10
   -- if (down0='0' and down='1') then present_state<="0100";end if; --�����¡�����ѡĿ����·״̬
    if (back0='0' and back='1') then present_state<="0001";end if;


  when "0011"=>  --ѡƱ��״̬
  
    if (confirm0='0' and confirm='1') then present_state<="0111";end if;  --ѡƱ��ȷ�Ϻ�ֱ��Ͷ��
    if (back0='0' and back='1') then present_state<="0010";end if;
    --flag<='0';

  when"0100"=>  --ѡĿ��վ��·״̬
  
    if (confirm0='0' and confirm='1') then present_state<="0101";end if;
    if (back0='0' and back='1') then present_state<="0010";

    end if;

  when "0101"=>  --ѡĿ��վվ��״̬
 
    if (confirm0='0' and confirm='1') then present_state<="1011";end if; --��ȷ�� ȥ��ʾ����
    if (back0='0' and back='1') then present_state<="0100";end if;

  when "0110"=>  --ѡƱ��״̬

    if (confirm0='0' and confirm='1') then present_state<="1100";end if; --��ȷ�� ȥ��ʾ�ܼ�
    if (back0='0' and back='1') then present_state<="0101";end if; --������ ȥ��ѡ�յ�վ
    --flag<='1';

  when "0111"=>  --Ͷ��״̬

    if (confirm0='0' and confirm='1') then --����ȷ����
     if (get_flag0='0') then
      if (get_real_pay>=get_ticket_price) then present_state<="1000"; 
      elsif(get_real_pay<get_total) then present_state<="1001";
      end if;
     elsif (get_flag0='1') then
      if (get_real_pay>=get_total) then present_state<="1000";  --�������Ǯ��Ӧ���Ķ࣬�����������Ʊ״̬
      elsif(get_real_pay<get_total) then present_state<="1001"; --Ǯ���������˱�״̬
      end if;
     end if;
    end if;

    if (back0='0' and back='1') then
       present_state<="1001";   --�����ؾ͵��˱�״̬����һ�����˳�Ǯ��
      --else present_state<="0110";
      --end if;
    end if; 

  when "1000"=>  --�����Ʊ״̬
    if (confirm0='0' and confirm='1') then present_state<="0000";end if;
    --if (get_up_to_5sec='1') then present_state<="0000";end if;  --�������5��û�����������ȴ�״̬

  when "1001"=>  --�˱�״̬
    if (confirm0='0' and confirm='1') then present_state<="0000";end if;
   -- if (get_up_to_5sec='1') then present_state<="0000";end if;  --�������5��û�����������ȴ�״̬
 
 when "1010"=>  --״̬10 �жϽ���ѡƱ�ۻ���ѡ�յ���
  if (up0='0' and up='1') then present_state<="0011";end if; --���� ȥѡƱ��
   if (down0='0' and down='1') then present_state<="0100";end if; --���� ȥѡ�յ���
 
  when "1011"=>  --��ʾ��ʼվ���յ�վ�ĵ���
    if (confirm0='0' and confirm='1') then present_state<="0110";end if; --��ȷ�� ȥѡƱ��
     if (back0='0' and back='1') then present_state<="0101";end if; --������ ȥѡ�յ�վ
     
  when "1100"=>  --��ʾ�ܼۣ�����*Ʊ����
         if (confirm0='0' and confirm='1') then present_state<="0111";end if; --��ȷ�� ȥͶ��
         if (back0='0' and back='1') then present_state<="0110";end if; --������ ȥ��ѡƱ��
         
  when others=>   --��ʼ״̬��s1
    present_state<="0000";

end case; 
end if;
end process;

end Behavioral;

