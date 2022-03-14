pico-8 cartridge // http://www.pico-8.com
version 35
__lua__
pico-8 cartridge // http://www.pico-8.com
version 34
__lua__
grid_x=0
grid_y=0 

flag_tile=0

x=64
y=64
dx=0 
dy=0
speed = 1


function _init_()


end

--maping etc

function _update()

	grid_x=flr(x/8) 
	grid_y=flr(y/8)
	flag_tile = fget(mget(grid_x,grid_y))
	
	if btn(0) then dx=-speed end
	if btn(1) then dx=speed end
	if btn(2) then dy=-speed end
	if btn(3) then dy=speed end
	
	if map_collision(x+dx,y,7,7) then
		dx=0 
	end
	
	if map_collision(x,y+dy,7,7) then
		dy=0 
	end
	
	x+=dx
	y+=dy
	 
	bounds()
end 

function _draw()
-- all the code that 
-- draaws things to the screen
	cls()
	map(0,0,0,0,16,16)	
	spr(1,x,y)

	
end

--removes boundaries
--function wrap() 

	--if x>127 then x=-8 end
--	if x<-8 then x=127 end 
--	if y>127 then y=-8 end
--	if y<-8 then y=127 end

--end

function bounds()
 
	if x <0 then x=0 end
	if x > 120 then x = 120 end
	if y < 0 then y = 0 end
	if y > 120 then y = 120 end
	
end

function map_collision(x,y,w,h)
	collide=false 
	
	--loop to see if collision is in
	--the x,y
	for i=x,x+w,w do 
		if fget(mget(i/8,y/8))>0 or
					fget(mget(i/8,(y+h)/8))>0 then 
					collide = true 
			end	
	end
	return collide
end

__gfx__
00000000000000001000000000000000100000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000011100000000000001110000000000001110000000000000055500000000000055500000000000005550000000000000000000000000000000
00700700000000111110000000000011111000000000011111000000000000555550000000000555550000000000055555000000000000000000000000000000
00077000000011111110000000000011111000000000011111000000000000505550000000000505050000000000055555000000000000000000000000000000
0007700000000e0eeee0000000000e0eee0e00000000eeeeeee00000000005555550000000000555550000000000055555000000000000000000000000000000
00700700000eeeeeeee0000000000eededee00000000eeeeeee00000000000555500000000000555550000000000055555000000000000000000000000000000
00000000000edeeeeee00000000000eeeee0000000000eeeee000000000000099900000000000099900000000000009990000000000000000000000000000000
00000000000eeeeeee000000000001eeeee100000000111111100000000000075900000000000597750000000000059995000000000000000000000000000000
0000000000000011110000000000e11111a1e000000e1111111e0000000000095900000000000599950000000000059995000000000000000000000000000000
00000000000011a1e10000000000e1111111e000000e1111e11e0000000000095900000000000599950000000000059995000000000000000000000000000000
0000000000011111e100e0000000e1111111e000000e11111e1e0000000000095900000000000599950000000000059995000000000000000000000000000000
0000000000011111e10ee0000000e5555555e0000000555e5e500000000000099900000000000099900000000000009990000000000000000000000000000000
0000000000005555e5ee000000000111111100000000111ee1100000000000009900000000000090900000000000009090000000000000000000000000000000
00000000000000011100000000000011011000000000011011000000000000009900000000000090900000000000009090000000000000000000000000000000
00000000000000011100000000000011011000000000011011000000000000009900000000000090900000000000009090000000000000000000000000000000
00000000000000444400000000000444044400000000444044400000000000044400000000000440440000000000044044000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000555000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000005555500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000055555550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000555555555000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000005555555555500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000055555555555550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000555555555555555000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000550005585500055000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000500005888500005000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000005500058a8500055000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000005500058a8500055000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000001005501058a8501055000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000e00550e058a850e055000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000100500105888501005000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00005555555555585555555555000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00005555555555555555555555000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000555555555555555555550000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000005555500050000055500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000400550040000004000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000400055040000004000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000400005555000004000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000400000045500104000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000400000040550e04000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000400000040055104000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000400000040005504000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000400000040000554000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000004440005545555544400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000004440055444000044400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000004440550444000044400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000004445500444000044400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
