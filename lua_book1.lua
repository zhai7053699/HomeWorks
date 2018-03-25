-- 阶乘
function fact(n)
	-- body
	if n == 0 then
		return 1
	else
	    return n*fact(n-1)
	end
end

--print(fact(5))

-- print("enter a number:")
-- a = io.read("*n")  -- 没反应
-- print(fact(b))

-- print(math.sin(10))

-- a = "hello"
-- print(#a)

-- print("45"*"2")

a = {}
a[1000] = 1
print(#a)
