-- 第5章 函数

local  count = 1
function incCount(n)
	-- body
	n = n or 1
	count = count + n
	return count
end

-- incCount(2)

-- print(incCount(3))

-- 多个返回值
-- s,e = string.find('hello Lua users','Lua')
-- print(s,e)

function maxinum(a)
	-- body
	local mi = 1
	local m = a[mi]

	for i,val in ipairs(a) do
		if val > m then
			mi = i
			m = val
		end
	end
	return m,mi
end

-- print(maxinum({3,5,6,10,23,15,32,1}))

-- 变长参数
function add(...)
	-- body
	local s = 0
	for i,v in ipairs{...} do
		s = s + v
	end
	return s
end

print(add(3,4,5,6,6))














