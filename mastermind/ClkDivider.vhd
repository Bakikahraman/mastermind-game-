library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity ClkDivider is
    Port (ClkIn : in std_logic; --giriş saat sinyali
          Divisor : in std_logic_vector(31 downto 0); --bölen değeri
          ClkOut : out std_logic); --çıkış saat sinyali
end ClkDivider;

architecture Behavioral of ClkDivider is

    signal ClkToggle : std_logic := '0';

begin
    --clkIn sinyalinin yükselen kenarı yakalandığında çalışır. Bir sayaç (counter) tanımlanır ve her yükselen kenarda bir artırılır.
    -- Eğer sayaç, Divisor değerine eşit olursa, ClkToggle sinyali 
    --terslenir ve sayaç sıfırlanır. Bu, giriş saat sinyalinin belirli bir oranda bölünerek çıkış saat sinyalinin oluşturulmasını sağlar.
--Son olarak, ClkOut sinyali ClkToggle sinyaline eşittir, böylece çıkış saat sinyali modülün dışında kullanılabilir.
    ClkOut <= ClkToggle;
    
    process (ClkIn) is
        variable counter : unsigned(31 downto 0) := x"00000000";
        begin
            if rising_edge(ClkIn) then
                counter := counter + 1;
                if (std_logic_vector(counter) = Divisor) then
                    ClkToggle <= not ClkToggle;
                    counter := x"00000000";
                end if;
            end if;
    end process;
end Behavioral;
