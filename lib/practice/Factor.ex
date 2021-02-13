defmodule Practice.Factor do
    def factor(num) do
        factorHelp(num, 2)
    end

    def factorHelp(num, inc) do
        cond do 
            num === 1 -> []
            rem(num, inc) === 0 -> [inc | factorHelp(div(num, inc), inc)]
            true -> factorHelp(num, inc + 1)
        end
    end
end
