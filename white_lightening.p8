pico-8 cartridge // http://www.pico-8.com
version 35
__lua__
--game loop 

function _init() 
	map_setup() 
	make_player()
	init_pickups()
end

function _update()
	move_player()
	update_pickups()
end

function _draw()
	cls() 
	draw_map()
	draw_player()
	draw_pickups()
end

-->8
--map code 

function map_setup() 
-- tile settings 
 wall=0 
 key=1 
 door=2 
 anim1=3
 anim2=4 
 lose=6 
 win=7 
--sprite flags^
end

function draw_map()
	mapx=flr(p.x/16)*16
	mapy=flr(p.y/16)*16
	camera(mapx*8,mapy*8)
	-- with flr we are getting
	--a const cordinate 
	--0x0 16x0 32x0
	
	map(0,0,0,0,128,64)
	
end

function is_tile(tile_type,x,y)
	tile = mget(x,y)
	has_flag=fget(tile,tile_type) 
	return has_flag
end

function can_move(x,y) 
	return not is_tile(wall,x,y)
	--here we are asking
	--is this a wall? 
	-- so with not we are inversing
	-- true so now is tile is false.
	-- so now if there is a wall.then
	-- true means there is a wall
end

function swap_tile(x,y) 
	tile=mget(x,y) 
	mset(x,y,tile+1)
	--asks what tile is at x,y
	-- then replaces it with 
	-- that tile + 1
	-- remember to replace 
	-- with like white lightening 
	-- or something
	
end

function get_key(x,y)
	p.keys+=1 
	swap_tile(x,y) 
	
end

function open_door(x,y)
	p.keys-=1 
	swap_tile(x,y)
	

end
-->8
--player code
function make_player() 
	p={} 
	
	p.x=3
	p.y=2 
	p.w=8
	p.h=8
	
	p.sprint=4
	p.keys=0 
	
end

function draw_player()
	spr(p.sprint,p.x*8,p.y*8) 
	
end

-- object, starting frame, number of frames, animation speed, flip
function anim(o,sf,nf,sp,fl)
  if(not o.a_ct) o.a_ct=0
  if(not o.a_st) o.a_st=0

  o.a_ct+=1

  if(o.a_ct%(30/sp)==0) then
    o.a_st+=1
    if(o.a_st==nf) o.a_st=0
  end

  o.a_fr=sf+o.a_st
  spr(o.a_fr,o.x,o.y,1,1,fl)
end


function move_player() --1 if and 3 else ifs allow for only 1 directional movement to elim diag movement
	newx=p.x 
	newy=p.y
 if btn(⬅️) then 
 	newx=newx-.3
 --shift left
 elseif btn(➡️) then
 	 newx=newx+.3 
 --shift right
 elseif btn(⬆️) then
 	 newy=newy-.3 
 -- shift up
 elseif btn(⬇️) then 
 	newy=newy+.3
 end
--shift down
	
	--letting using key
	interact(newx,newy)
	
	if(can_move(newx,newy)) then
		p.x=mid(0,newx,127) 
		p.y=mid(0,newy,63)
		--sets our bounds so we cant
		-- move off the map.
	end

end 

function interact(x,y) 
	if (is_tile(key,x,y)) then 
	 get_key(x,y)
	elseif (is_tile(door,x,y) and p.keys>0) then open_door(x,y)
	end
	
end

-->8
--pick up code
function init_pickups() 

pu = {}
add(pu,{s=21,x=8, y=3}) --sprite 17 is the beer and the location of that sprite
add(pu,{s=21,x=26, y=5})
add(pu,{s=21,x=15, y=11})

end

function update_pickups()

end

function draw_pickups()

	for p in all(pu) do
	spr(p.s, p.x*8, p.y*8)
	end

end



__gfx__
00000000000000001110111100080000008888205555555555555555655510660000000000000000000000000000000000000000000000000000000000000000
00000000011101111110111111858111008888885555555555555555511110650000000000000000000000000000000000000000000000000000000000000000
0070070000000000111011110888880000f0f0f05554455555500555111110510000000000000000000000000000000000000000000000000000000000000000
0007700011101110111011111855581000fffff05444445550000055000000000000000000000000000000000000000000000000000000000000000000000000
000770000000000011101111088888000f99999f5004445550000055110666550000000000000000000000000000000000000000000000000000000000000000
007007000111011100000000188888010f99999f54444a5550000055110655510000000000000000000000000000000000000000000000000000000000000000
0000000000000000110110110888880000ccccc05004445550000055110511110000000000000000000000000000000000000000000000000000000000000000
0000000011011101110110111888880100c000c05444445550000055111111110000000000000000000000000000000000000000000000000000000000000000
11111111111111111110111111111111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11111111111111111110111111111111000000001106601101110111000000000000000000000000000000000000000000000000000000000000000000000000
11111111111111111110111111161111000000000066060000000000000000000000000000000000000000000000000000000000000000000000000000000000
1111111111111111111011111167611100444404117cc81011101110000000000000000000000000000000000000000000000000000000000000000000000000
1111111111111111111011111111111154484004007cc70000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000001111111111101111161116114444444401c87c1100110111000000000000000000000000000000000000000000000000000000000000000000000000
11011011111111111110111167616761004444400087770000000000000000000000000000000000000000000000000000000000000000000000000000000000
11011011111111111110111111111111004040401166660111011101000000000000000000000000000000000000000000000000000000000000000000000000
11111011000000000000000011111111111011114a4444a4a4aa4a44000000000000000000000000000000000000000000000000000000000000000000000000
11111011110110111101101111111111111011114a4444a451991511000000000000000000000000000000000000000000000000000000000000000000000000
11111000110110111101101111111111111011114a4444a411111111000000000000000000000000000000000000000000000000000000000000000000000000
11111011000000000000000011111111111011114a4444a411111111000000000000000000000000000000000000000000000000000000000000000000000000
1111101111111111111011111111111111101111aaa99aaa51111511000000000000000000000000000000000000000000000000000000000000000000000000
111110001111111111101111111111110000000049499494a4444a44000000000000000000000000000000000000000000000000000000000000000000000000
11111011111111111110111111111111110110114a4444a4a4444a44000000000000000000000000000000000000000000000000000000000000000000000000
11111011111111111110111111111111110110114a4444a4a4444a44000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000001101111100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11011011110110111101111100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11011011110110110001111100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000001101111100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11111011110111111101111100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11111011110111110001111100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11111000000111111101111100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11111011110111111101111100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
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
10101010101070101010101010101010101010101010101010101010101010707010101010101010101010101010101010101010101010101010101010101010
10707000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
70707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070101010101010101070
70700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000707070707070707070
__gff__
0000000100050001000000000000000000000001000200000000000000000000000000000003010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010101010101010101010101010101010101010101010101010101010107070707070707070101010101010101010101010101070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0707010101010107070707070707070707070707070101010101010101010101010101010101010101010107010101010101070707010101010101010101010107070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0701010101010101010101010101010101010101070101010101010101010101010101010101010101010707010101010101010107070101010101010101010107070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0701010101010101010101010101010101010101070101010101010101010115010101010101010707070701010101010101010101010101010101010101010101070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0701010101010101010101070707070101010107010101010101010101010101010101010101070701010101010101010101010101010101010101010101010101070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0707070707010107070707070101070101010107010101010101010101010101010101010107070101010101010101010101010101010101010101010101010101070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010107010107010101010107070101010107070101010101010101010101010101010707010101010101010101010101010101010101010101010101010107070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010107010107010101010101070701010101070707010101010101010101010101070701010101070707010101010101010101010101010101011501010107070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101070707010107010707070707070101010101010101070707070101010101010107070101010707070101070101010101010101010101010101010101010101070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0107070101010107070707010101010101010101010101010101070101010101010107010101070701010101070701010101010101010101010101010101010101070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0707010101010107070101010101010101010101010101010101070701010101010107070707070101010101010701010101010101010101010101010101010107070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0701010101010107010101010101010101010101010101010101010101010101010101070701010101010101070101010101010101010101010101010101010107070700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0701010101010101070101010101010101010101010101010101010101010101010101010101010101010101070101010101010101010101010101010101010107070700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0707010101010101070701010101010101010107010101010101010101010101010101010101010101010107010101010101010101010101010101010101010101070700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0107070707010101070701070707010101010107010101010101010101010101010101011501010101010701010101010101010101010101010101010101010101070700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010107010101070707070101010101010107070101010707070707070707070701010101010107070101010101010101010101010101010101010101010101070700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010107070101010101010101010101010101010707070101010101010107070107010101010701070101010101010101010101010101010101010101010101070700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101070101010101010101010101010101010101010101010101010107010101010101010101070101010101010101010101010101010101010101010107070700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101070707070701010101010101010101010101010101010101010107010101010101010101070101010101010101010101010101010101010101010107070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010101010101010101010101010101070707010101010101010101070707010101010101010101010101010101010101010107070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101011501010101010101010101010101010107070707070101010101010101010101010107070707070707010101010101010101010101010107070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010101010101010101010107010101070101010101010101010101010101010101010107070701010101010101010101010107070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101010101010101010101010101010101010107011501070101010107010101010101010101010101010101010701010101010101010101010107070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0707070707070101010101010101010707070101010101070707010101070707010107070101010101010101010101010101010107010101010101010101010707000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010707010101010707070101070701010101010101010101010107010101070701010101010101010101010101010707010101010101010101070707000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010707010707070707010101010701010101010101010101070707010101010701010101010101010101010101010107010101010101010101070707070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010701010101010107070101010707010101010101010101070701010107070701010101010101010101010101010107070101010101010101070701070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010701010101010101070101010101010101010101010101010707070707070101010107010101010101010101010101070707010101010107070101070700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101011501010707010101010101070101010101010101010101010101010101070107070707070707010101010101010101010101010101070707070107070101010700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010107070707010707070101010101010101011501010101010107070101010101010101010101010101010101010101010101010101070701010101010700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0101010101010101070101010101070101010101010101010101010101010107010101010101010101010101010101010101010101010101010101010101011501010700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000400000706003050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
