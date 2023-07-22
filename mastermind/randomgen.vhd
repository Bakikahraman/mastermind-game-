
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity randomgen is
  Port (
   clk:in std_logic;
   a:out std_logic_vector(11 downto 0));
end randomgen;
--İçeride temp adında bir değişken tanımlanır ve başlangıç değeri "000000000001" olarak atanır.
--Daha sonra, her döngüde temp değişkeninin 10 ila 0 arasındaki bitleri ile XOR işlemi yapılır ve sonuç temp değişkenine atanır. Bu, yeni bir rastgele bit üretir.
--Son olarak, temp değeri a çıkışına atanır.wait until (clk = '0') ifadesi, saat sinyalinin '0' seviyesine düşmesini beklemek için kullanılır
--Bu, tasarımın sadece saat sinyali düştüğünde çalışmasını sağlar ve bu sayede doğru bir şekilde zamanlama yapılır.


architecture Behavioral of randomgen is

begin

    Gen:process is
    variable temp:std_logic_vector(11 downto 0) := "000000000001";
    begin
        temp := temp(10 downto 0 )  & (temp(11) xor temp(10) );
        a <= temp;
        wait until (clk = '0');
    end process Gen;

end Behavioral;
