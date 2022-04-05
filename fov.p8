pico-8 cartridge // http://www.pico-8.com
version 35
__lua__
-- field of view
-- written by dw817 (03-15-22)

-- standard ⌂ pico-8 license

-- vvhat's new ?
-- + made them all functions!
-- + made beam bigger.
-- + allow for different types
--   of beams.
-- + made beam comparison
--   smaller and faster code,
--   uses less cpu.


function _init()

-- how big is the field of
-- view radius in pixels?
dist=48

-- what is the pattern seen
-- when showing the view cone
-- for the enemy ?
-- 1 = solid
-- 2 = dotted
-- 3 = more spaces between dots
dots=2

-- can it be seen ?
-- 0 = no
-- 1 = yes
view=1

-- starting position of player.
px=20
py=20

-- player's animation frame
-- step.
pa=0

-- starting position of enemy.
ex=64
ey=64

-- the enemy is currently
-- facing to the left.
-- 0 = left
-- 1 = up
-- 2 = right
-- 3 = down
ef=0

-- which do the arrow keys
-- control ?
-- 0 = player
-- 1 = enemy
whic=0

end

function _update()

cls()

-- press ❎ button to swap
-- between controlling the
-- player and the enemy.
if btnp(❎) then
  whic=1-whic
end

-- if you press 🅾️ then change
-- between showing the line of
-- sight and not.
if btnp(🅾️) then
  view=1-view
end

-- show this color for scan
-- beam if no target present.
c=view

-- check to see if player is
-- touching the beam, visible
-- or not.
if inbeam(px,py,ex,ey,ef,dist) then

-- if so, change beam color to
-- bright red.
  c=8

-- and show gotcha! sprite.
  spr(7,120,0)

end

-- if viewing dots or player
-- is in field of sight, show
-- the beam.
if view==1 or c==8 then
  drawbeam(ex,ey,ef,dist,c,dots)
end
   
-- draw player's sprite +
-- animation steps.
spr(pa\4%2+1,px-4,py-4)

-- draw enemy sprite.
spr(3+ef,ex-3,ey-3)

-- if controlling the player,
-- move the player according
-- to the arrow keys pressed
-- and animate the sprite
-- slightly.
if whic==0 then
  if btn()>0 and btn()<16 then
    pa=pa+1
  end
  if btn(⬅️) then
    px=px-1
  elseif btn(➡️) then
    px=px+1
  end
  if btn(⬆️) then
    py=py-1
  elseif btn(⬇️) then
    py=py+1
  end

-- otherwise control the enemy.
-- move them according to the
-- arrow keys pressed. also
-- also change their direction
-- according to the arrow
-- key pressed.
else
  if btn(⬅️) then
    ex=ex-1
    ef=0
  elseif btn(➡️) then
    ex=ex+1
    ef=2
  end
  if btn(⬆️) then
    ey=ey-1
    ef=1
  elseif btn(⬇️) then
    ey=ey+1
    ef=3
  end
end

-- show how much cpu is being
-- used.
print((stat(1)*100\1).."%:cpu",0,0,7)

-- show which direction the
-- enemy is facing.
print("eface="..ef,32,0)

-- show which the arrow keys
-- are controlling. either the
-- player or the enemy.
spr(2+whic,112,0)

end

-- draw solid or dotted beam:
-- x=sprite's x-position
-- y=sprite's y-position
-- d=direction sprite is
-- facing:
--   0=left, 1=up, 2=right,
--   3=down
-- r=radius of beam in pixels
-- c=color to plot
-- s=spacing:
--   1=normal, more cpu
--   2=dotted, less cpu
function drawbeam(x,y,d,r,c,s)local p,b,e,h,v,a=pset,x,x-r,y if d==1then b=y e=y-r h=x elseif d==2then e=x+r elseif d==3then b=y e=y+r h=x end for i=b,e,sgn(e-b)*s do a=b-i if d==2or d==3then a=i-b end for j=h-a/2,h+a/2,s do if d==0or d==2then p(i,j,c)else p(j,i,c)end end end end

-- check to see if player is
-- in sight of beam. returns
-- true if this is the case.
-- assumes sprites are 8𝘹8
-- pixels:
-- h=player horizontal
-- v=player vertical
-- x=enemy horizontal
-- y=enemy vertical
-- d=direction enemy is facing:
--   0=left, 1=up, 2=right,
--   3=down
-- r=radius of beam in pixels
function inbeam(h,v,x,y,d,r)local a,b=abs(h-x)-4,abs(v-y)-4r+=4if(d==0and x-h<r and b<(x-h)/2)or(d==1and y-v<r and a<(y-v)/2)or(d==2and h-x<r and b<(h-x)/2)or(d==3and v-y<r and a<(v-y)/2)or(a<3and b<3)then return true end end
