-- title:  8 Bit Panda
-- author: Bruno Oliveira / Giovanni Giorgi (mods)
-- desc:   A panda platformer
-- script: lua
-- saveid: eightbitpanda
--
-- WARNING: this file must be kept under
-- 64kB (TIC-80 limit)!

NAME="8-BIT PANDA"
C=8
ROWS=17
COLS=30
SCRW=240
SCRH=136

-- jump sequence (delta y at each frame)
JUMP_DY={-3,-3,-3,-3,-2,-2,-2,-2,
  -1,-1,0,0,0,0,0}

-- swimming seq (implemented as a "jump")
SWIM_JUMP_DY={-2,-2,-1,-1,-1,-1,0,0,0,0,0}
RESURF_DY={-3,-3,-2,-2,-1,-1,0,0,0,0,0}

-- attack sequence (1=preparing,
-- 2=attack,3=recovery)
ATK_SEQ={1,1,1,1,2,3,3,3}

-- die sequence (dx,dy)
DIE_SEQ={{-1,-1},{-2,-2},{-3,-3},{-4,-4},
 {-5,-5},{-6,-5},{-7,-4},{-8,-3},{-8,-2},
 {-8,1},{-8,3},{-8,5},{-8,9},{-8,13},
 {-8,17},{-8,21},{-8,26},{-8,32},{-8,39}
}

-- display x coords in which
-- to keep the player (for scrolling)
SX_MIN=50
SX_MAX=70

-- entity/tile solidity
SOL={
 NOT=0,  -- not solid
 HALF=1, -- only when going down,
         -- allows movement upward.
 FULL=2, -- fully solid
}

FIRE={
 -- duration of fire powerup
 DUR=1000,
 -- time between successive fires.
 INTERVAL=20,
 -- offset from player pos
 OFFY=2,OFFX=7,OFFX_FLIP=-2,
 OFFX_PLANE=14,OFFY_PLANE=8,
 -- projectile collision rect
 COLL={x=0,y=0,w=3,h=3},
}

-- Tiles
-- 0: empty
-- 1-79: static solid blocks
-- 80-127: decorative
-- 128-239: entities
-- 240-255: special markers
T={
 EMPTY=0,
 -- platform that's only solid when
 -- going down, but allows upward move
 HPLAF=4,
 
 SURF=16,
 WATER=32,
 WFALL=48,

 TARMAC=52, -- (where plane can land).

 -- sprite id above which tiles are
 -- non-solid decorative elements
 FIRST_DECO=80,

 -- level-end gate components
 GATE_L=110,GATE_R=111,
 GATE_L2=142,GATE_R=143,

 -- tile id above which tiles are
 -- representative of entities, not bg
 FIRST_ENT=128,
 
 -- tile id above which tiles have special
 -- meanings
 FIRST_META=240,
 
 -- number markers (used for level
 -- packing and annotations).
 META_NUM_0=240,
   -- followed by nums 1-9.
 
 -- A/B markers (entity-specific meaning)
 META_A=254,
 META_B=255
}

-- Autocomplete of tiles patterns.
-- Auto filled when top left map tile
-- is present.
TPAT={
 [85]={w=2,h=2},
 [87]={w=2,h=2},
 [94]={w=2,h=2},
 [89]={w=2,h=2},
}

-- solidity of tiles (overrides)
TSOL={
 [T.EMPTY]=SOL.NOT,
 [T.HPLAF]=SOL.HALF,
 [T.SURF]=SOL.NOT,
 [T.WATER]=SOL.NOT,
 [T.WFALL]=SOL.NOT,
}

-- animated tiles
TANIM={
 [T.SURF]={T.SURF,332},
 [T.WFALL]={T.WFALL,333,334,335},
}

-- sprites
S={
 PLR={  -- player sprites
  STAND=257,
  WALK1=258,
  WALK2=259,
  JUMP=273,
  SWING=276,
  SWING_C=260,
  HIT=277,
  HIT_C=278,
  DIE=274,
  SWIM1=267,SWIM2=268,
  -- overlays for fire powerup
  FIRE_BAMBOO=262, -- bamboo powerup
  FIRE_F=265,  -- suit, front
  FIRE_P=266,  -- suit, profile
  FIRE_S=284,  -- suit, swimming
  -- overlays for super panda powerup
  SUPER_F=281, -- suit, front
  SUPER_P=282, -- suit, profile
  SUPER_S=283, -- suit, swimming
 },
 EN={  -- enemy sprites
  A=176,
  B=177,
  DEMON=178,
  DEMON_THROW=293,
  SLIME=180,
  BAT=181,
  HSLIME=182, -- hidden slime
  DASHER=183,
  VBAT=184,
  SDEMON=185, -- snow demon
  SDEMON_THROW=300,
  PDEMON=188,  -- plasma demon
  PDEMON_THROW=317,
  FISH=189,
  FISH2=190,
 },
 -- crumbling block
 CRUMBLE=193,CRUMBLE_2=304,CRUMBLE_3=305,
 FIREBALL=179,
 FIRE_1=263,FIRE_2=264,
 LIFT=192,
 PFIRE=263, -- player fire (bamboo)
 FIRE_PWUP=129,
 -- background mountains
 BGMNT={DIAG=496,FULL=497},
 SCRIM=498, -- also 499,500
 SPIKE=194,
 CHEST=195,CHEST_OPEN=311,
 -- timed platform (opens and closes)
 TPLAF=196,TPLAF_HALF=312,TPLAF_OFF=313,
 SUPER_PWUP=130,
 SIGN=197,
 SNOWBALL=186,
 FLAG=198,
 FLAG_T=326,  -- flag after taken
 ICICLE=187,   -- icicle while hanging
 ICICLE_F=303, -- icicle falling
 PLANE=132,  -- plane (item)
 AVIATOR=336, -- aviator sprite (3x2)
 AVIATOR_PROP_1=339, -- propeller anim
 AVIATOR_PROP_2=340, -- propeller anim
 PLASMA=279,  -- plasma ball
 SICICLE=199,   -- stone-themed icicle,
                -- while hanging
 SICICLE_F=319, -- stone-themed icicle,
                -- while falling
 FUEL=200,      -- fuel item
 IC_FUEL=332,   -- icon for HUD
 TINY_NUM_00=480, -- "00" sprite
 TINY_NUM_50=481, -- "50" sprite
 TINY_NUM_R1=482, -- 1-10, right aligned
 
 -- food items
 FOOD={LEAF=128,A=133,B=134,C=135,D=136},
 
 SURF1=332,SURF2=333, -- water surface fx

 -- world map tiles
 WLD={
  -- tiles that player can walk on
  ROADS={13,14,15,30,31,46,47},
  -- level tiles
  LVL1=61,LVL2=62,LVL3=63,
  LVLF=79, -- finale level
  -- "cleared level" tile
  LVLC=463,
 },
 
 -- Special EIDs that don't correspond to
 -- sprites. ID must be > 512
 POP=600, -- entity that dies immediately
          -- with a particle effect
}

-- Sprite numbers also function as entity
-- IDs. For readability we write S.FOO
-- when it's a sprite but EID.FOO when
-- it identifies an entity type.
EID=S

-- anims for each entity ID
ANIM={
 [EID.EN.A]={S.EN.A,290},
 [EID.EN.B]={S.EN.B,291},
 [EID.EN.DEMON]={S.EN.DEMON,292},
 [EID.EN.SLIME]={S.EN.SLIME,295},
 [EID.EN.BAT]={S.EN.BAT,296},
 [EID.FIREBALL]={S.FIREBALL,294},
 [EID.FOOD.LEAF]={S.FOOD.LEAF,288,289},
 [EID.PFIRE]={S.PFIRE,264},
 [EID.FIRE_PWUP]={S.FIRE_PWUP,306,307},
 [EID.EN.HSLIME]={S.EN.HSLIME,297},
 [EID.SPIKE]={S.SPIKE,308},
 [EID.CHEST]={S.CHEST,309,310},
 [EID.EN.DASHER]={S.EN.DASHER,314},
 [EID.EN.VBAT]={S.EN.VBAT,298},
 [EID.SUPER_PWUP]={S.SUPER_PWUP,320,321},
 [EID.EN.SDEMON]={S.EN.SDEMON,299},
 [EID.SNOWBALL]={S.SNOWBALL,301},
 [EID.FOOD.D]={S.FOOD.D,322,323,324},
 [EID.FLAG]={S.FLAG,325},
 [EID.ICICLE]={S.ICICLE,302},
 [EID.SICICLE]={S.SICICLE,318},
 [EID.PLANE]={S.PLANE,327,328,329},
 [EID.EN.PDEMON]={S.EN.PDEMON,316},
 [EID.PLASMA]={S.PLASMA,280},
 [EID.FUEL]={S.FUEL,330,331},
 [EID.EN.FISH]={S.EN.FISH,368},
 [EID.EN.FISH2]={S.EN.FISH2,369},
}

PLANE={
 START_FUEL=2000,
 MAX_FUEL=4000,
 FUEL_INC=1000,
 FUEL_BAR_W=50
}

-- modes
M={
 BOOT=0,
 TITLE=1,    -- title screen
 TUT=2,      -- instructions
 RESTORE=3,  -- prompting to restore game
 WLD=4,      -- world map
 PREROLL=5,  -- "LEVEL X-Y" banner
 PLAY=6,
 DYING=7,    -- die anim
 EOL=8,      -- end of level
 GAMEOVER=9,
 WIN=10,     -- beat entire game
}

-- collider rects
CR={
 PLR={x=2,y=0,w=4,h=8},
 AVIATOR={x=-6,y=2,w=18,h=10},
 -- default
 DFLT={x=2,y=0,w=4,h=8},
 FULL={x=0,y=0,w=8,h=8},
 -- small projectiles
 BALL={x=2,y=2,w=3,h=3},
 -- just top rows
 TOP={x=0,y=0,w=8,h=2},
 -- player attack
 ATK={x=6,y=0,w=7,h=8},
 -- what value to use for x instead if
 -- player is flipped (facing left)
 ATK_FLIP_X=-5,
 FOOD={x=1,y=1,w=6,h=6},
}

-- max dist entity to update it
ENT_MAX_DIST=220

-- EIDs to always update regardless of
-- distance.
ALWAYS_UPDATED_EIDS={
 -- lifts need to always be updated for
 -- position determinism.
 [EID.LIFT]=true
}

-- player damage types
DMG={
 MELEE=0,      -- melee attack
 FIRE=1,       -- fire from fire powerup
 PLANE_FIRE=2, -- fire from plane
}

-- default palette
PAL={
 [0]=0x000000,  [1]=0x402434,
 [2]=0x30346d,  [3]=0x4a4a4a,
 [4]=0x854c30,  [5]=0x346524,
 [6]=0xd04648,  [7]=0x757161,
 [8]=0x34446d,  [9]=0xd27d2c,
 [10]=0x8595a1, [11]=0x6daa2c,
 [12]=0x1ce68d, [13]=0x6dc2ca,
 [14]=0xdad45e, [15]=0xdeeed6,
}

-- music tracks
BGM={A=0,B=1,EOL=2,C=3,WLD=4,TITLE=5,
 FINAL=6,WIN=7}

-- bgm for each mode (except M.PLAY, which
-- is special)
BGMM={
 [M.TITLE]=BGM.TITLE,
 [M.WLD]=BGM.WLD,
 [M.EOL]=BGM.EOL,
 [M.WIN]=BGM.WIN,
}

-- map data is organized in pages.
-- Each page is 30x17. TIC80 has 64 map
-- pages laid out as an 8x8 grid. We
-- number them in reading order, so 0
-- is top left, 63 is bottom right.

-- Level info.
-- Levels in the cart are packed
-- (RLE compressed). When a level is loaded,
-- it gets unpacked to the top 8 map pages
-- (0,0-239,16).
--  palor: palette overrides
--  pkstart: map page where packed
--    level starts.
--  pklen: length of level. Entire level
--    must be on same page row, can't
--    span multiple page rows.
LVL={
 {
  name="1-1",bg=2,
  palor={},
  pkstart=8,pklen=3,
  mus=BGM.A,
 },
 {
  name="1-2",bg=0,
  palor={[8]=0x102428},
  pkstart=11,pklen=2,
  mus=BGM.B,
 },
 {
  name="1-3",bg=2,
  pkstart=13,pklen=3,
  mus=BGM.C,
  save=true,
 },
 {
  name="2-1",bg=1,
  palor={[8]=0x553838},
  pkstart=16,pklen=3,
  mus=BGM.A,
 },
 {
  name="2-2",bg=0,
  palor={[8]=0x553838},
  pkstart=19,pklen=2,
  snow={clr=2},
  mus=BGM.B,
 },
 {
  name="2-3",bg=1,
  palor={[8]=0x553838},
  pkstart=21,pklen=3,
  mus=BGM.C,
  save=true,
 },
 {
  name="3-1",bg=2,
  palor={[8]=0x7171ae},
  pkstart=24,pklen=3,
  snow={clr=10},
  mus=BGM.A,
 },
 {
  name="3-2",bg=0,
  palor={[8]=0x3c3c50},
  pkstart=27,pklen=2,
  snow={clr=10},
  mus=BGM.B,
 },
 {
  name="3-3",bg=2,
  palor={[8]=0x7171ae},
  pkstart=29,pklen=3,
  mus=BGM.C,
  save=true,
 },
 {
  name="4-1",bg=2,
  palor={[2]=0x443c14,[8]=0x504410},
  pkstart=32,pklen=3,
  mus=BGM.A,
 },
 {
  name="4-2",bg=2,
  palor={[2]=0x443c14,[8]=0x504410},
  pkstart=35,pklen=2,
  mus=BGM.B,
 },
 {
  name="4-3",bg=2,
  palor={[2]=0x443c14,[8]=0x504410},
  pkstart=37,pklen=3,
  mus=BGM.C,
  save=true,
 },
 {
  name="5-1",bg=1,
  palor={[8]=0x553838},
  pkstart=40,pklen=3,
  mus=BGM.A,
 },
 {
  name="5-2",bg=1,
  palor={[8]=0x553838},
  pkstart=43,pklen=2,
  mus=BGM.B,
 },
 {
  name="5-3",bg=1,
  palor={[8]=0x553838},
  pkstart=45,pklen=3,
  mus=BGM.C,
  save=true,
 },
 {
  name="6-1",bg=0,
  palor={[8]=0x303030},
  pkstart=48,pklen=3,
  mus=BGM.FINAL,
  snow={clr=8},
 },
 {
  name="6-2",bg=0,
  palor={[8]=0x303030},
  pkstart=51,pklen=5,
  mus=BGM.FINAL,
  snow={clr=8},
 },
}

-- length of unpacked level, in cols
-- 240 means the top 8 map pages
LVL_LEN=240

-- sound specs
SND={
 KILL={sfxid=62,note=30,dur=5},
 JUMP={sfxid=61,note=30,dur=4},
 SWIM={sfxid=61,note=50,dur=3},
 ATTACK={sfxid=62,note=40,dur=4},
 POINT={sfxid=60,note=60,dur=5,speed=3},
 DIE={sfxid=63,note=18,dur=20,speed=-1},
 HURT={sfxid=63,note="C-4",dur=4},
 PWUP={sfxid=60,note=45,dur=15,speed=-2},
 ONEUP={sfxid=60,note=40,dur=60,speed=-3},
 PLANE={sfxid=59,note="C-4",dur=70,speed=-3},
 OPEN={sfxid=62,note="C-3",dur=4,speed=-2},
}

-- world map consts
WLD={
 -- foreground tile page
 FPAGE=61,
 -- background tile page
 BPAGE=62,
}

-- WLD point of interest types
POI={
 LVL=0,
}

-- settings
Sett={
 snd=true,
 mus=true
}

-- game state
Game={
 -- mode
 m=M.BOOT,
 -- ticks since mode start
 t=0,
 -- current level# we're playing
 lvlNo=0,
 lvl=nil,  -- shortcut to LVL[lvlNo]
 -- scroll offset in current level
 scr=0,
 -- auto-generated background mountains
 bgmnt=nil,
 -- snow flakes (x,y pairs). These don't
 -- change, we just shift when rendering.
 snow=nil,
 -- highest level cleared by player,
 -- -1 if no level cleared
 topLvl=-1,
}

-- world map state
Wld={
 -- points of interest (levels, etc)
 pois={},
 -- savegame start pos (maps start level
 -- to col,row)
 spos={},
 plr={
  -- start pos
  x0=-1,y0=-1,
  -- player pos, in pixels not row/col
  x=0,y=0,
  -- player move dir, if moving. Will move
  -- until plr arrives at next cell
  dx=0,dy=0,
  -- last move dir
  ldx=0,ldy=0,
  -- true iff player facing left
  flipped=false,
 }
}

-- player
Plr={} -- deep-copied from PLR_INIT_STATE
PLR_INIT_STATE={
 lives=3,
 x=0,y=0, -- current pos
 dx=0,dy=0, -- last movement
 flipped=false, -- if true, is facing left
 jmp=0, -- 0=not jumping, otherwise
        -- it's the cur jump frame
 jmpSeq=JUMP_DY, -- set during jump
 grounded=false,
 swim=false,
 -- true if plr is near surface of water
 surf=false,
 -- attack state. 0=not attacking,
 -- >0 indexes into ATK_SEQ
 atk=0,
 -- die animation frame, 0=not dying
 -- indexes into DIE_SEQ
 dying=0,
 -- nudge (movement resulting from
 -- collisions)
 nudgeX=0,nudgeY=0,
 -- if >0, has fire bamboo powerup
 -- and this is the countdown to end
 firePwup=0,
 -- if >0 player has fired bamboo.
 -- This is ticks until player can fire
 -- again.
 fireCd=0,
 -- if >0, is invulnerable for this
 -- many ticks, 0 if not invulnerable
 invuln=0,
 -- if true, has the super panda powerup
 super=false,
 -- if != 0, player is being dragged
 -- horizontally (forced to move in that
 -- direction -- >0 is right, <0 is left)
 -- The abs value is how many frames
 -- this lasts for.
 drag=0,
 -- the sign message (index) the player
 -- is currently reading.
 signMsg=0,
 -- sign cycle counter: 1 when just
 -- starting to read sign, increases.
 -- when player stops reading sign,
 -- decreases back to 0.
 signC=0,
 -- respawn pos, 0,0 if unset
 respX=-1,respY=-1,
 -- if >0, the player is on the plane
 -- and this is the fuel left (ticks).
 plane=0,
 -- current score
 score=0,
 -- for performance, we keep the
 -- stringified score ready for display
 scoreDisp={text=nil,value=-1},
 -- time (Game.t) when score last changed
 scoreMt=-999,
 -- if >0, player is blocked from moving
 -- for that many frames.
 locked=0,
}

-- max cycle counter for signs
SIGN_C_MAX=10

-- sign texts.
SIGN_MSGS={
 [0]={
  l1="Green bamboo protects",
  l2="against one enemy attack.",
 },
 [1]={
  l1="Yellow bamboo allows you to throw",
  l2="bamboo shoots (limited time).",
 },
 [2]={
  l1="Pick up leaves and food to get",
  l2="points. 10,000 = extra life.",
 },
 [4]={
  l1="Bon voyage!",
  l2="Don't run out of fuel.",
 },
}

-- entities
Ents={}

-- particles
Parts={}

-- score toasts
Toasts={}

-- animated tiles, for quick lookup
-- indexed by COLUMN.
-- Tanims[c] is a list of integers
-- indicating rows of animated tiles.
Tanims={}

function SetMode(m)
 Game.m=m
 Game.t=0
 if m~=M.PLAY and m~=M.DYING and
   m~=M.EOL then
  ResetPal()
 end
 UpdateMus()
end

function UpdateMus()
 if Game.m==M.PLAY then
  PlayMus(Game.lvl.mus)
 else
  PlayMus(BGMM[Game.m] or -1)
 end
end

function TIC()
 -- GG ENABLE DEBUG
 -- Plr.dbg= true
 -- ENDs
 CheckDbgMenu()
 if Plr.dbg then
  DbgTic()
  return
 end
 Game.t=Game.t+1
 TICF[Game.m]()
end

function CheckDbgMenu()
 if not btn(6) then
  Game.dbgkc=0
  return
 end
 if btnp(0) then
  Game.dbgkc=10+(Game.dbgkc or 0)
 end
 if btnp(1) then
  Game.dbgkc=1+(Game.dbgkc or 0)
 end
 if Game.dbgkc==42 then Plr.dbg=true end
end

function Boot()
 ResetPal()
 WldInit()
 SetMode(M.TITLE)
end

-- restores default palette with
-- the given overrides.
function ResetPal(palor)
 for c=0,15 do
  local clr=PAL[c]
  if palor and palor[c] then
   clr=palor[c]
  end
  poke(0x3fc0+c*3+0,(clr>>16)&255)
  poke(0x3fc0+c*3+1,(clr>>8)&255)
  poke(0x3fc0+c*3+2,clr&255)
 end
end

function TitleTic()
 ResetPal()
 cls(2)
 local m=MapPageStart(63)
 map(m.c,m.r,30,17,0,0,0)

 spr(S.PLR.WALK1+(time()//128)%2,16,104,0)
 rect(0,0,240,24,5)
 print(NAME,88,10)
 rect(0,24,240,1,15)
 rect(0,26,240,1,5)
 rect(0,SCRH-8,SCRW,8,0)
 print("github.com/btco/panda",60,SCRH-7,7)
 
 if (time()//512)%2>0 then
  print("- PRESS 'Z' TO START -",65,84,15)
 end

 RendSpotFx(COLS//2,ROWS//2,Game.t)
 if btnp(4) then
  SetMode(M.RESTORE)
 end
end

function RestoreTic()
 local saveLvl=pmem(0) or 0
 if saveLvl<1 then
  StartGame(1)
  return
 end
 
 Game.restoreSel=Game.restoreSel or 0
 
 cls(0)
 local X=40
 local Y1=30
 local Y2=60
 print("CONTINUE (LEVEL "..
   LVL[saveLvl].name ..")",X,Y1)
 print("START NEW GAME",X,Y2)
 spr(S.PLR.STAND,X-20,
  Iif(Game.restoreSel>0,Y2,Y1))
 if btnp(0) or btnp(1) then
  Game.restoreSel=
   Iif(Game.restoreSel>0,0,1)
 elseif btnp(4) then
  StartGame(Game.restoreSel>0 and
    1 or saveLvl)
 end
end

function TutTic()
 cls(0)
 if Game.tutdone then
  StartLvl(1)
  return
 end
 local p=MapPageStart(56)
 map(p.c,p.r,COLS,ROWS)

 print("CONTROLS",100,10)
 print("JUMP",56,55);
 print("ATTACK",72,90);
 print("MOVE",160,50);
 print("10,000 PTS = EXTRA LIFE",60,110,3);

 if Game.t>150 and 0==((Game.t//16)%2) then
   print("- Press Z to continue -",60,130)
 end

 if Game.t>150 and btnp(4) then
  Game.tutdone=true
  StartLvl(1)
 end
end

function WldTic()
 WldUpdate()
 WldRend()
end

function PrerollTic()
 cls(0)
 print("LEVEL "..Game.lvl.name,100,40)
 spr(S.PLR.STAND,105,60)
 print("X " .. Plr.lives,125,60)
 -- GG Orig 60 
 if Game.t>30 then
  SetMode(M.PLAY)
 end
end

function PlayTic()
 if Plr.dbgFly then
  UpdateDbgFly()
 else
  UpdatePlr()
  UpdateEnts()
  UpdateParts()
  DetectColl()
  ApplyNudge()
  CheckEndLvl()
 end
 AdjustScroll() 
 Rend()
 if Game.m==M.PLAY then
  RendSpotFx((Plr.x-Game.scr)//C,
    Plr.y//C,Game.t)
 end
end

function EolTic()
 if Game.t>160 then
  AdvanceLvl()
  return
 end
 Rend()
 print("LEVEL CLEAR",85,20)
end

function DyingTic()
 Plr.dying=Plr.dying+1

 if Game.t>100 then
  if Plr.lives>1 then
   Plr.lives=Plr.lives-1
   SetMode(M.WLD)
  else
   SetMode(M.GAMEOVER)
  end
 else
  Rend()
 end
end

function GameOverTic()
 cls(0)
 print("GAME OVER!",92,50)
 if Game.t>150 then
  SetMode(M.TITLE)
 end
end

function WinTic()
 cls(0)
 Game.scr=0
 local m=MapPageStart(57)
 map(m.c,m.r,
   math.min(30,(Game.t-300)//8),17,0,0,0)
 print("THE END!",100,
   math.max(20,SCRH-Game.t//2))
 print("Thanks for playing!",70,
   math.max(30,120+SCRH-Game.t//2))
 
 if Game.t%100==0 then
  SpawnParts(PFX.FW,Rnd(40,SCRW-40),
   Rnd(40,SCRH-40),Rnd(2,15))
 end

 UpdateParts()
 RendParts()

 if Game.t>1200 and btnp(4) then
  SetMode(M.TITLE)
 end
end

TICF={
 [M.BOOT]=Boot,
 [M.TITLE]=TitleTic,
 [M.TUT]=TutTic,
 [M.RESTORE]=RestoreTic,
 [M.WLD]=WldTic,
 [M.PREROLL]=PrerollTic,
 [M.PLAY]=PlayTic,
 [M.DYING]=DyingTic,
 [M.GAMEOVER]=GameOverTic,
 [M.EOL]=EolTic,
 [M.WIN]=WinTic,
}

function StartGame(startLvlNo)
 Game.topLvl=startLvlNo-1
 Plr=DeepCopy(PLR_INIT_STATE)
 -- put player at the right start pos
 local sp=Wld.spos[startLvlNo] or 
   {x=Wld.plr.x0,y=Wld.plr.y0}
 Wld.plr.x=sp.x
 Wld.plr.y=sp.y
 SetMode(M.WLD)
end

function StartLvl(lvlNo)
 local oldLvlNo=Game.lvlNo
 Game.lvlNo=lvlNo
 Game.lvl=LVL[lvlNo]
 Game.scr=0
 local old=Plr
 Plr=DeepCopy(PLR_INIT_STATE)
 -- preserve lives, score
 Plr.lives=old.lives
 Plr.score=old.score
 Plr.super=old.super
 if oldLvlNo==lvlNo then
  Plr.respX=old.respX
  Plr.respY=old.respY
 end
 SetMode(M.PREROLL)
 Ents={}
 Parts={}
 Toasts={}
 Tanims={}
 UnpackLvl(lvlNo,UMODE.GAME)
 GenBgMnt()
 GenSnow()
 ResetPal(Game.lvl.palor)
 AdjustRespawnPos()
end

function AdjustRespawnPos()
 if Plr.respX<0 then return end
 for i=1,#Ents do
  local e=Ents[i]
  if e.eid==EID.FLAG and e.x<Plr.respX then
   EntRepl(e,EID.FLAG_T)
  end
 end
 Plr.x=Plr.respX
 Plr.y=Plr.respY
end

-- generates background mountains.
function GenBgMnt()
 local MAX_Y=12
 local MIN_Y=2
 -- min/max countdown to change direction:
 local MIN_CD=2
 local MAX_CD=6
 Game.bgmnt={}
 RndSeed(Game.lvlNo)
 local y=Rnd(MIN_Y,MAX_Y)
 local dy=1
 local cd=Rnd(MIN_CD,MAX_CD)
 for i=1,LVL_LEN do
  Ins(Game.bgmnt,{y=y,dy=dy})
  cd=cd-1
  if cd<=0 or y+dy<MIN_Y or y+dy>MAX_Y then
   -- keep same y but change direction
   cd=Rnd(MIN_CD,MAX_CD)
   dy=-dy
  else
   y=y+dy
  end
 end
 RndSeed(time())
end

function GenSnow()
 if not Game.lvl.snow then
  Game.snow=nil
  return
 end
 Game.snow={}
 for r=0,ROWS-1,2 do
  for c=0,COLS-1,2 do
   Ins(Game.snow,{
    x=c*C+Rnd(-8,8),
    y=r*C+Rnd(-8,8)
   })
  end
 end
end

-- Whether player is on solid ground.
function IsOnGround()
 return not CanMove(Plr.x,Plr.y+1)
end

-- Get level tile at given point
function LvlTileAtPt(x,y)
 return LvlTile(x//C,y//C)
end

-- Get level tile.
function LvlTile(c,r)
 if c<0 or c>=LVL_LEN then return 0 end
 if r<0 then return 0 end
 -- bottom-most tile repeats infinitely
 -- below (to allow player to swim
 -- when bottom tile is water).
 if r>=ROWS then r=ROWS-1 end
 return mget(c,r)
end

function SetLvlTile(c,r,t)
 if c<0 or c>=LVL_LEN then return false end
 if r<0 or r>=ROWS then return false end
 mset(c,r,t)
end

function UpdatePlr()
 local oldx=Plr.x
 local oldy=Plr.y

 Plr.plane=Max(Plr.plane-1,0)
 Plr.fireCd=Max(Plr.fireCd-1,0)
 Plr.firePwup=Max(Plr.firePwup-1,0)
 Plr.invuln=Max(Plr.invuln-1,0)
 Plr.drag=Iif2(Plr.drag>0,Plr.drag-1,
   Plr.drag<0,Plr.drag+1,0)
 Plr.signC=Max(Plr.signC-1,0)
 Plr.locked=Max(Plr.locked-1,0)
 UpdateSwimState()
 
 local swimmod=Plr.swim and Game.t%2 or 0

 if (Plr.plane==0 and Plr.jmp==0 and
   not IsOnGround()) then
  -- fall
  Plr.y=Plr.y+1-swimmod
 end
 
 -- check if player fell into pit
 if Plr.y>SCRH+8 then
  StartDying()
  return
 end

 -- horizontal movement
 local dx=0
 local dy=0
 local wantLeft=Plr.locked==0 and
   Iif(Plr.drag==0,btn(2),Plr.drag<0)
 local wantRight=Plr.locked==0 and
   Iif(Plr.drag==0,btn(3),Plr.drag>0)
 local wantJmp=Plr.locked==0 and
   Plr.plane==0 and btnp(4) and Plr.drag==0
 local wantAtk=Plr.locked==0 and
   btnp(5) and Plr.drag==0

 if wantLeft then
  dx=-1+swimmod
  -- plane doesn't flip
  Plr.flipped=true
 elseif wantRight then
  dx=1-swimmod
  Plr.flipped=false
 end

 -- vertical movement (plane only)
 dy=dy+Iif2(Plr.plane>0 and btn(0) and
   Plr.y>8,-1,
   Plr.plane>0 and btn(1) and
   Plr.y<SCRH-16,1,0)

 -- is player flipped (facing left?)
 Plr.flipped=Iif3(
   Plr.plane>0,false,btn(2),true,
   btn(3),false,Plr.flipped)

 TryMoveBy(dx,dy)
 
 Plr.grounded=Plr.plane==0 and IsOnGround()
 
 local canJmp=Plr.grounded or Plr.swim
 -- jump
 if wantJmp and canJmp then
  Plr.jmp=1
  Plr.jmpSeq=Plr.surf and
    RESURF_DY or
    (Plr.swim and SWIM_JUMP_DY or
    JUMP_DY)
  Snd(Plr.surf and SND.JUMP or
    Plr.swim and SND.SWIM or SND.JUMP)
  -- TODO play swim snd if swim
 end

 if Plr.jmp>#Plr.jmpSeq then
  -- end jump
  Plr.jmp=0
 elseif Plr.jmp>0 then
  local ok=TryMoveBy(
    0,Plr.jmpSeq[Plr.jmp])
  -- if blocked, cancel jump
  Plr.jmp=ok and Plr.jmp+1 or 0
 end
 
 -- attack
 if Plr.atk==0 then
  if wantAtk then
   -- start attack sequence
   if Plr.plane==0 then Plr.atk=1 end
   Snd(SND.ATTACK)
   TryFire()
  end
 elseif Plr.atk>#ATK_SEQ then
  -- end of attack sequence
  Plr.atk=0
 else
  -- advance attack sequence
  Plr.atk=Plr.atk+1
 end

 -- check plane landing
 if Plr.plane>0 then CheckTarmac() end

 Plr.dx=Plr.x-oldx
 Plr.dy=Plr.y-oldy
end

function IsWater(t)
 return t==T.WATER or t==T.SURF or
   t==T.WFALL
end

function UpdateSwimState()
 local wtop=IsWater(
   LvlTileAtPt(Plr.x+4,Plr.y+1))
 local wbottom=IsWater(
   LvlTileAtPt(Plr.x+4,Plr.y+7))
 local wtop2=IsWater(
   LvlTileAtPt(Plr.x+4,Plr.y-8))
 Plr.swim=wtop and wbottom
 -- is plr near surface?
 Plr.surf=wbottom and not wtop2
end

function UpdateDbgFly()
 local d=Iif(btn(4),5,1)
 if btn(0) then Plr.y=Plr.y-d end
 if btn(1) then Plr.y=Plr.y+d end
 if btn(2) then Plr.x=Plr.x-d end
 if btn(3) then Plr.x=Plr.x+d end
 if btn(5) then Plr.dbgFly=false end
end

function TryFire()
 if Plr.firePwup<1 and Plr.plane==0 then
  return
 end
 if Plr.fireCd>0 then return end
 Plr.fireCd=FIRE.INTERVAL
 local x=Plr.x
 if Plr.plane==0 then
  x=x+(Plr.flipped and
    FIRE.OFFX_FLIP or FIRE.OFFX)
 else
  -- end of plane
  x=x+FIRE.OFFX_PLANE
 end
 local y=Plr.y+Iif(Plr.plane>0,
   FIRE.OFFY_PLANE,FIRE.OFFY)
 local e=EntAdd(EID.PFIRE,x,y)
 e.moveDx=Plr.plane>0 and 2 or
   (Plr.flipped and -1 or 1)
 e.ttl=Plr.plane>0 and e.ttl//2 or e.ttl
end

function ApplyNudge()
 Plr.y=Plr.y+Plr.nudgeY
 Plr.x=Plr.x+Plr.nudgeX
 Plr.nudgeX=0
 Plr.nudgeY=0
end

function TryMoveBy(dx,dy)
 if CanMove(Plr.x+dx,Plr.y+dy) then
  Plr.x=Plr.x+dx
  Plr.y=Plr.y+dy
  return true
 end
 return false
end

function GetPlrCr()
 return Iif(Plr.plane>0,CR.AVIATOR,CR.PLR)
end

-- Check if plr can move to given pos.
function CanMove(x,y)
 local dy=y-Plr.y
 local pcr=GetPlrCr()
 local r=CanMoveEx(x,y,pcr,dy)
 if not r then return false end

 -- check if would bump into solid ent
 local pr=RectXLate(pcr,x,y)
 for i=1,#Ents do
  local e=Ents[i]
  local effSolid=(e.sol==SOL.FULL) or
   (e.sol==SOL.HALF and dy>0 and
   Plr.y+5<e.y) -- (HACK)
  if effSolid then
   local er=RectXLate(e.coll,e.x,e.y)
   if RectIsct(pr,er) then
    return false
   end
  end
 end
 return true
end

function EntCanMove(e,x,y)
 return CanMoveEx(x,y,e.coll,y-e.y)
end

function GetTileSol(t)
 local s=TSOL[t]
 -- see if an override is present.
 if s~=nil then return s end
 -- default:
 return Iif(t>=T.FIRST_DECO,SOL.NOT,SOL.FULL)
end

-- x,y: candidate pos; cr: collision rect
-- dy: y direction of movement
function CanMoveEx(x,y,cr,dy)
 local x1=x+cr.x
 local y1=y+cr.y
 local x2=x1+cr.w-1
 local y2=y1+cr.h-1
 -- check all tiles touched by the rect
 local startC=x1//C
 local endC=x2//C
 local startR=y1//C
 local endR=y2//C
 for c=startC,endC do
  for r=startR,endR do
   local sol=GetTileSol(LvlTile(c,r))
   if sol==SOL.FULL then return false end
  end
 end

 -- special case: check for half-solidity
 -- tiles. Only solid when standing on
 -- top of them (y2%C==0) and going
 -- down (dy>0).
 local sA=GetTileSol(LvlTileAtPt(x1,y2))
 local sB=GetTileSol(LvlTileAtPt(x2,y2))
 if dy>0 and (sA==SOL.HALF or
   sB==SOL.HALF) and
   y2%C==0 then return false end
 
 return true
end

function EntWouldFall(e,x)
 return EntCanMove(e,x,e.y+1)
end

-- check if player landed plane on tarmac
function CheckTarmac()
 local pr=RectXLate(
   CR.AVIATOR,Plr.x,Plr.y)
 local bottom=pr.y+pr.h+1
 local t1=LvlTileAtPt(pr.x,bottom)
 local t2=LvlTileAtPt(pr.x+pr.w,bottom)
 if t1==T.TARMAC and t2==T.TARMAC then
  -- landed
  Plr.plane=0
  SpawnParts(PFX.POP,Plr.x+4,Plr.y,14)
  -- TODO: more vfx, sfx
 end
end

function AdjustScroll()
 local dispx=Plr.x-Game.scr
 if dispx>SX_MAX then
  Game.scr=Plr.x-SX_MAX
 elseif dispx<SX_MIN then
  Game.scr=Plr.x-SX_MIN
 end
end

function AddToast(points,x,y)
 local rem=points%100
 if points>1000 or (rem~=50 and rem~=0) then
  return
 end
 local sp2=rem==50 and S.TINY_NUM_50 or
   S.TINY_NUM_00
 local sp1=points>=100 and 
   (S.TINY_NUM_R1-1+points//100) or 0
 Ins(Toasts,{
    x=Iif(points>=100,x-8,x-12),
    y=y,ttl=40,sp1=sp1,sp2=sp2})
end

-- tx,ty: position where to show toast
-- (optional)
function AddScore(points,tx,ty)
 local old=Plr.score
 Plr.score=Plr.score+points
 Plr.scoreMt=Game.t
 if (old//10000)<(Plr.score//10000) then
  Snd(SND.ONEUP)
  Plr.lives=Plr.lives+1
  -- TODO: vfx
 else
  Snd(SND.POINT)
 end
 if tx and ty then
  AddToast(points,tx,ty)
 end
end

function StartDying()
 SetMode(M.DYING)
 Snd(SND.DIE)
 Plr.dying=1 -- start die anim
 Plr.super=false
 Plr.firePwup=0
 Plr.plane=0
end

function EntAdd(newEid,newX,newY)
 local e={
  eid=newEid,
  x=newX,
  y=newY
 }
 Ins(Ents,e)
 EntInit(e)
 return e
end

function EntInit(e)
 -- check if we have an animation for it
 if ANIM[e.eid] then
  e.anim=ANIM[e.eid]
  e.sprite=e.anim[1]
 else
  -- default to static sprite image
  e.sprite=e.eid
 end
 -- whether ent sprite is flipped
 e.flipped=false
 -- collider rect
 e.coll=CR.DFLT
 -- solidity (defaults to not solid)
 e.sol=SOL.NOT
 -- EBT entry
 local ebte=EBT[e.eid]
 -- behaviors
 e.beh=ebte and ebte.beh or {}
 -- copy initial behavior data to entity
 for _,b in pairs(e.beh) do
  ShallowMerge(e,b.data)
 end
 -- overlay the entity-defined data.
 if ebte and ebte.data then
  ShallowMerge(e,ebte.data)
 end
 -- call the entity init funcs
 for _,b in pairs(e.beh) do
  if b.init then b.init(e) end
 end
end

function EntRepl(e,eid,data)
 e.dead=true
 local newE=EntAdd(eid,e.x,e.y)
 if data then
  ShallowMerge(newE,data)
 end
end

function EntHasBeh(e,soughtBeh)
 for _,b in pairs(e.beh) do
  if b==soughtBeh then return true end
 end
 return false
end

function EntAddBeh(e,beh)
 if EntHasBeh(e,beh) then return end
 -- note: can't mutate the original
 -- e.beh because it's a shared ref.
 e.beh=DeepCopy(e.beh)
 ShallowMerge(e,beh.data,true)
 Ins(e.beh,beh)
end

function UpdateEnts()
 -- iterate backwards so we can delete
 for i=#Ents,1,-1 do
  local e=Ents[i]
  UpdateEnt(e)
  if e.dead then
   -- delete
   Rem(Ents,i)
  end  
 end
end

function UpdateEnt(e)
 if not ALWAYS_UPDATED_EIDS[e.eid] and
   Abs(e.x-Plr.x)>ENT_MAX_DIST then
  -- too far, don't update
  return
 end
 -- update anim frame
 if e.anim then
  e.sprite=e.anim[1+(time()//128)%#e.anim]  
 end
 -- run update behaviors
 for _,b in pairs(e.beh) do
  if b.update then b.update(e) end
 end
end

function GetEntAt(x,y)
 for i=1,#Ents do
  local e=Ents[i]
  if e.x==x and e.y==y then return e end
 end
 return nil
end

-- detect collisions
function DetectColl()
 -- player rect
 local pr=RectXLate(GetPlrCr(),
  Plr.x,Plr.y)
  
 -- attack rect
 local ar=nil
 if ATK_SEQ[Plr.atk]==2 then
  -- player is attacking, so check if
  -- entity was hit by attack
  ar=RectXLate(CR.ATK,Plr.x,Plr.y)
  if Plr.flipped then
   ar.x=Plr.x+CR.ATK_FLIP_X
  end
 end

 for i=1,#Ents do
  local e=Ents[i]
  local er=RectXLate(e.coll,e.x,e.y)
  if RectIsct(pr,er) then
   -- collision between player and ent
   HandlePlrColl(e)
  elseif ar and RectIsct(ar,er) then
   -- ent hit by player attack
   HandleDamage(e,DMG.MELEE)
  end
 end
end

function CheckEndLvl()
 local t=LvlTileAtPt(
   Plr.x+C//2,Plr.y+C//2)
 if t==T.GATE_L or t==T.GATE_R or
    t==T.GATE_L2 or t==T.GATE_R2 then
  EndLvl()
 end
end

function EndLvl()
 Game.topLvl=Max(
   Game.topLvl,Game.lvlNo)
 SetMode(M.EOL)
end

function AdvanceLvl()
 -- save game if we should
 if Game.lvl.save then
  pmem(0,Max(pmem(0) or 0,
    Game.lvlNo+1))
 end
 if Game.lvlNo>=#LVL then
  -- end of game.
  SetMode(M.WIN)
 else
  -- go back to map.
  SetMode(M.WLD)
 end
end

-- handle collision w/ given ent
function HandlePlrColl(e)
 for _,b in pairs(e.beh) do
  if b.coll then b.coll(e) end
  if e.dead then break end
 end
end

function HandleDamage(e,dtype)
 for _,b in pairs(e.beh) do
  if b.dmg then b.dmg(e,dtype) end
  if e.dead then
   SpawnParts(PFX.POP,e.x+4,e.y+4,e.clr)
   Snd(SND.KILL)
   break
  end
 end
end

function HandlePlrHurt()
 if Plr.invuln>0 then return end
 if Plr.plane==0 and Plr.super then
  Snd(SND.HURT)
  Plr.super=false
  Plr.invuln=100
  Plr.drag=Iif(Plr.dx>=0,-10,10)
  Plr.jmp=0
 else
  StartDying()
 end
end

function Snd(spec)
 if not Sett.snd then return end
 sfx(spec.sfxid,spec.note,spec.dur,
   0,spec.vol or 15,spec.speed or 0)
end

function PlayMus(musid)
 if Sett.mus or musid==-1 then
  music(musid)
 end
end


---------------------------------------
-- PARTICLES
---------------------------------------

-- possible effects
PFX={
 POP={
  rad=4,
  count=15,
  speed=4,
  fall=true,
  ttl=15
 },
 FW={ -- fireworks
  rad=3,
  count=40,
  speed=1,
  fall=false,
  ttl=100
 }
}

-- fx=one of the effects in PFX
-- cx,cy=center, clr=the color
function SpawnParts(fx,cx,cy,clr)
 for i=1,fx.count do
  local r=Rnd01()*fx.rad
  local phi=Rnd01()*math.pi*2
  local part={
   x=cx+r*Cos(phi),
   y=cy+r*Sin(phi),
   vx=fx.speed*Cos(phi),
   vy=fx.speed*Sin(phi),
   fall=fx.fall,
   ttl=fx.ttl,
   age=0,
   clr=clr
  }
  Ins(Parts,part)
 end
end

function UpdateParts()
 -- iterate backwards so we can delete
 for i=#Parts,1,-1 do
  local p=Parts[i]
  p.age=p.age+1
  if p.age>=p.ttl then
   -- delete
   Rem(Parts,i)
  else
   p.x=p.x+p.vx
   p.y=p.y+p.vy+(p.fall and p.age//2 or 0)
  end
 end
end

function RendParts()
 for i,p in pairs(Parts) do
  pix(p.x-Game.scr,p.y,p.clr)
 end
end

---------------------------------------
-- WLD MAP
---------------------------------------
-- convert "World W-L" into index
function Wl(w,l) return (w-1)*3+l end

-- Init world (runs once at start of app).
function WldInit()
 for r=0,ROWS-1 do
  for c=0,COLS-1 do
   local t=WldFgTile(c,r)
   local lval=WldLvlVal(t)
   if t==T.META_A then
    -- player start pos
    Wld.plr.x0=c*C
    Wld.plr.y0=(r-1)*C
   elseif t==T.META_B then
    local mv=WldGetTag(c,r)
    -- savegame start pos
    Wld.spos[Wl(mv,1)]={
      x=c*C,y=(r-1)*C}
   elseif lval>0 then
    local mv=WldGetTag(c,r)
    -- It's a level tile.
    local poi={c=c,r=r,
     t=POI.LVL,lvl=Wl(mv,lval)}
    Ins(Wld.pois,poi)
   end
  end
 end
end

-- Looks around tc,tr for a numeric tag.
function WldGetTag(tc,tr)
 for r=tr-1,tr+1 do
  for c=tc-1,tc+1 do
   local mv=MetaVal(WldFgTile(c,r),0)
   if mv>0 then
    return mv
   end
  end
 end
 trace("No WLD tag @"..tc..","..tr)
 return 0
end

-- Returns the value (1, 2, 3) of a WLD
-- level tile.
function WldLvlVal(t)
 return Iif4(t==S.WLD.LVLF,1,
   t==S.WLD.LVL1,1,
   t==S.WLD.LVL2,2,
   t==S.WLD.LVL3,3,0)
end

function WldFgTile(c,r)
 return MapPageTile(WLD.FPAGE,c,r)
end

function WldBgTile(c,r)
 return MapPageTile(WLD.BPAGE,c,r)
end

function WldPoiAt(c,r)
 for i=1,#Wld.pois do
  local poi=Wld.pois[i]
  if poi.c==c and poi.r==r then
   return poi
  end
 end
 return nil
end

function WldHasRoadAt(c,r)
 local t=WldFgTile(c,r)
 for i=1,#S.WLD.ROADS do
  if S.WLD.ROADS[i]==t then
   return true
  end
 end
 return false
end

function WldUpdate()
 local p=Wld.plr  -- shorthand

 if p.dx~=0 or p.dy~=0 then
  -- Just move.
  p.x=p.x+p.dx
  p.y=p.y+p.dy
  if p.x%C==0 and p.y%C==0 then
   -- reached destination.
   p.ldx=p.dx
   p.ldy=p.dy
   p.dx=0
   p.dy=0
  end
  return
 end

 if btn(0) then WldTryMove(0,-1) end
 if btn(1) then WldTryMove(0,1) end
 if btn(2) then WldTryMove(-1,0) end
 if btn(3) then WldTryMove(1,0) end

 Wld.plr.flipped=Iif(
   Iif(Wld.plr.flipped,btn(3),btn(2)),
   not Wld.plr.flipped,
   Wld.plr.flipped) -- wtf

 if btnp(4) then
  local poi=WldPoiAt(p.x//C,p.y//C)
  if poi and poi.lvl>Game.topLvl then
   if poi.lvl==1 then
    SetMode(M.TUT)
   else
    StartLvl(poi.lvl)
   end
  end
 end
end

function WldTryMove(dx,dy)
 local p=Wld.plr  -- shorthand

 -- if we are in locked POI, we can only
 -- come back the way we came.
 local poi=WldPoiAt(p.x//C,p.y//C)
 if not Plr.dbgFly and poi and
   poi.lvl>Game.topLvl and
   (dx ~= -p.ldx or dy ~= -p.ldy) then
  return 
 end

 -- target row,col
 local tc=p.x//C+dx
 local tr=p.y//C+dy
 if WldHasRoadAt(tc,tr) or
    WldPoiAt(tc,tr) then
  -- Destination is a road or level.
  -- Move is valid.
  p.dx=dx
  p.dy=dy
  return
 end
end

function WldFgRemapFunc(t)
 return t<T.FIRST_META and t or 0 
end

function WldRend()
 if Game.m~=M.WLD then return end
 cls(2)
 rect(0,SCRH-8,SCRW,8,0)
 local fp=MapPageStart(WLD.FPAGE)
 local bp=MapPageStart(WLD.BPAGE)
 -- render map bg
 map(bp.c,bp.r,COLS,ROWS,0,0,0,1)
 -- render map fg, excluding markers
 map(fp.c,fp.r,COLS,ROWS,0,0,0,1,
   WldFgRemapFunc)

 -- render the "off" version of level
 -- tiles on top of cleared levels.
 for _,poi in pairs(Wld.pois) do
  if poi.lvl<=Game.topLvl then
   spr(S.WLD.LVLC,poi.c*C,poi.r*C,0)
  end
 end

 print("SELECT LEVEL TO PLAY",
   70,10)
 print("= MOVE",34,SCRH-6)
 print("= ENTER LEVEL",98,SCRH-6)

 RendSpotFx(Wld.plr.x//C,
   Wld.plr.y//C,Game.t)
 if 0==(Game.t//16)%2 then
  rectb(Wld.plr.x-3,Wld.plr.y-3,13,13,15)
 end
 spr(S.PLR.STAND,Wld.plr.x,Wld.plr.y,0,
   1,Wld.plr.flipped and 1 or 0)
 RendHud()
end

---------------------------------------
-- LEVEL UNPACKING
---------------------------------------
-- unpack modes
UMODE={
 GAME=0, -- unpack for gameplay
 EDIT=1, -- unpack for editing
}

function MapPageStart(pageNo)
 return {c=(pageNo%8)*30,r=(pageNo//8)*17} 
end

function MapPageTile(pageNo,c,r,newVal)
 local pstart=MapPageStart(pageNo)
 if newVal then
  mset(c+pstart.c,r+pstart.r,newVal)
 end
 return mget(c+pstart.c,r+pstart.r)
end

-- Unpacked level is written to top 8
-- map pages (cells 0,0-239,16).
function UnpackLvl(lvlNo,mode)
 local lvl=LVL[lvlNo]
 local start=MapPageStart(lvl.pkstart)
 local offc=start.c
 local offr=start.r
 local len=lvl.pklen*30
 local endc=FindLvlEndCol(offc,offr,len)

 MapClear(0,0,LVL_LEN,ROWS)
 
 -- next output col
 local outc=0
 
 -- for each col in packed map
 for c=offc,endc do
  local cmd=mget(c,offr)
  local copies=MetaVal(cmd,1)
  -- create that many copies of this col
  for i=1,copies do
   CreateCol(c,outc,offr,mode==UMODE.GAME)
   -- advance output col
   outc=outc+1
   if outc>=LVL_LEN then
    trace("ERROR: level too long: "..lvlNo)
    return
   end
  end
 end

 -- if in gameplay, expand patterns and
 -- remove special markers
 -- (first META_A is player start pos)
 if mode==UMODE.GAME then
  for c=0,LVL_LEN-1 do
   for r=0,ROWS-1 do
    local t=mget(c,r)
    local tpat=TPAT[t]
    if tpat then ExpandTpat(tpat,c,r) end
    if Plr.x==0 and Plr.y==0 and
      t==T.META_A then
     -- player start position.
     Plr.x=c*C
     Plr.y=r*C
    end
    if t>=T.FIRST_META then
     mset(c,r,0)
    end
   end
  end
  if Plr.x==0 and Plr.y==0 then
   trace("*** start pos UNSET L"..lvlNo)
  end
  FillWater()
  SetUpTanims()
 end
end

-- expand tile pattern at c,r
function ExpandTpat(tpat,c,r)
 local s=mget(c,r)
 for i=0,tpat.w-1 do
  for j=0,tpat.h-1 do
   mset(c+i,r+j,s+j*16+i)
  end
 end
end

-- Sets up tile animations.
function SetUpTanims()
 for c=0,LVL_LEN-1 do
  for r=0,ROWS-1 do
   local t=mget(c,r)
   if TANIM[t] then
    TanimAdd(c,r)
   end
  end
 end
end

function FindLvlEndCol(c0,r0,len)
 -- iterate backwards until we find a
 -- non-empty col.
 for c=c0+len-1,c0,-1 do
  for r=r0,r0+ROWS-1 do
   if mget(c,r)>0 then
    -- rightmost non empty col
    return c
   end
  end
 end
 return c0
end

function FillWater()
 -- We fill downward from surface tiles,
 -- Downward AND upward from water tiles.
 local surfs={}  -- surface tiles
 local waters={} -- water tiles
 for c=LVL_LEN-1,0,-1 do
  for r=ROWS-1,0,-1 do
   if mget(c,r)==T.SURF then
    Ins(surfs,{c=c,r=r})
   elseif mget(c,r)==T.WATER then
    Ins(waters,{c=c,r=r})
   end
  end
 end
 
 for i=1,#surfs do
  local s=surfs[i]
  -- fill water below this tile
  FillWaterAt(s.c,s.r,1)
 end
 for i=1,#waters do
  local s=waters[i]
  -- fill water above AND below this tile
  FillWaterAt(s.c,s.r,-1)
  FillWaterAt(s.c,s.r,1)
 end
end

-- Fill water starting (but not including)
-- given tile, in the given direction
-- (1:down, -1:up)
function FillWaterAt(c,r0,dir)
 local from=r0+dir
 local to=Iif(dir>0,ROWS-1,0)
 for r=from,to,dir do
  if mget(c,r)==T.EMPTY then
   mset(c,r,T.WATER)
  else
   return
  end
 end
end

function TanimAdd(c,r)
 if Tanims[c] then
  Ins(Tanims[c],r)
 else
  Tanims[c]={r}
 end
end

-- pack lvl from 0,0-239,16 to the packed
-- level area of the indicated level
function PackLvl(lvlNo)
 local lvl=LVL[lvlNo]
 local start=MapPageStart(lvl.pkstart)
 local outc=start.c
 local outr=start.r
 local len=lvl.pklen*30
 
 local endc=FindLvlEndCol(0,0,LVL_LEN)
  
 -- pack
 local reps=0
 MapClear(outc,outr,len,ROWS)
 for c=0,endc do
  if c>0 and MapColsEqual(c,c-1,0) and
    reps<12 then
   -- increment repeat marker on prev col
   local m=mget(outc-1,outr)  
   m=Iif(m==0,T.META_NUM_0+2,m+1)
   mset(outc-1,outr,m)
   reps=reps+1
  else
   reps=1
   -- copy col to packed level
   MapCopy(c,0,outc,outr,1,ROWS)
   outc=outc+1
   if outc>=start.c+len then
    trace("Capacity exceeded.")
    return false
   end
  end
 end
 trace("packed "..(endc+1).." -> "..
  (outc+1-start.c))
 return true
end

-- Create map col (dstc,0)-(dstc,ROWS-1)
-- from source col located at
-- (srcc,offr)-(srcc,offr+ROWS-1).
-- if ie, instantiates entities.
function CreateCol(srcc,dstc,offr,ie)
 -- copy entire column first
 MapCopy(srcc,offr,dstc,0,1,ROWS)
 mset(dstc,0,T.EMPTY) -- top cell is empty
 if not ie then return end
 -- instantiate entities
 for r=1,ROWS-1 do
  local t=mget(dstc,r)
  if t>=T.FIRST_ENT and EBT[t] then
   -- entity tile: create entity
   mset(dstc,r,T.EMPTY)
   EntAdd(t,dstc*C,r*C)
  end
 end
end

---------------------------------------
-- RENDERING
---------------------------------------

function Rend()
 RendBg()
 if Game.snow then RendSnow() end
 RendMap()
 RendTanims()
 RendEnts()
 RendToasts()
 if Game.m==M.EOL then RendScrim() end
 RendPlr()
 RendParts()
 RendHud()
 RendSign()
end

function RendBg()
 local END_R=ROWS
 cls(Game.lvl.bg)
 local offset=Game.scr//2+50
 -- If i is a col# of mountains (starting
 -- at index 1), then its screen pos
 -- sx=(i-1)*C-off
 -- Solving for i, i=1+(sx+off)/C
 -- so at the left of screen, sx=0, we
 -- have i=1+off/C
 local startI=Max(1,1+offset//C)
 local endI=Min(
   startI+COLS,#Game.bgmnt)
 for i=startI,endI do
  local sx=(i-1)*C-offset
  local part=Game.bgmnt[i]
  for r=part.y,END_R do
   local spid=Iif(r==part.y,
    S.BGMNT.DIAG,S.BGMNT.FULL)
   spr(spid,(i-1)*C-offset,r*C,0,1,
    Iif(part.dy>0,1,0))
  end
 end
end

function RendSnow()
 local dx=-Game.scr
 local dy=Game.t//2
 for _,p in pairs(Game.snow) do
  local sx=((p.x+dx)%SCRW+SCRW)%SCRW
  local sy=((p.y+dy)%SCRH+SCRH)%SCRH
  pix(sx,sy,Game.lvl.snow.clr)
 end
end

function RendToasts()
 for i=#Toasts,1,-1 do
  local t=Toasts[i]
  t.ttl=t.ttl-1
  if t.ttl<=0 then
   Toasts[i]=Toasts[#Toasts]
   Rem(Toasts)
  else
   t.y=t.y-1
   spr(t.sp1,t.x-Game.scr,t.y,0)
   spr(t.sp2,t.x-Game.scr+C,t.y,0)
  end
 end
end

function RendMap()
 -- col c is rendered at
 --   sx=-Game.scr+c*C
 -- Setting sx=0 and solving for c
 --   c=Game.scr//C
 local c=Game.scr//C
 local sx=-Game.scr+c*C
 local w=Min(COLS+1,LVL_LEN-c)
 if c<0 then
  sx=sx+C*(-c)
  c=0
 end
 map(
  -- col,row,w,h
  c,0,w,ROWS,
  -- sx,sy,colorkey,scale
  sx,0,0,1)
end

function RendPlr()
 local spid
 local walking=false

 if Plr.plane>0 then
  RendPlane()
  return
 end

 if Plr.dying>0 then
  spid=S.PLR.DIE
 elseif Plr.atk>0 then
  spid=
    ATK_SEQ[Plr.atk]==1 and S.PLR.SWING
    or S.PLR.HIT
 elseif Plr.grounded then
  if btn(2) or btn(3) then
   spid=S.PLR.WALK1+time()%2
   walking=true
  else
   spid=S.PLR.STAND
  end
 elseif Plr.swim then
  spid=S.PLR.SWIM1+(Game.t//4)%2
 else
  spid=S.PLR.JUMP
 end 
 
 local sx=Plr.x-Game.scr
 local sy=Plr.y
 local flip=Plr.flipped and 1 or 0
 
 -- apply dying animation
 if spid==S.PLR.DIE then
  if Plr.dying<=#DIE_SEQ then
   sx=sx+DIE_SEQ[Plr.dying][1]
   sy=sy+DIE_SEQ[Plr.dying][2]
  else
   sx=-1000
   sy=-1000
  end
 end

 -- if invulnerable, blink
 if Plr.invuln>0 and
   0==(Game.t//4)%2 then return end
 
 spr(spid,sx,sy,0,1,flip)
 
 -- extra sprite for attack states
 if spid==S.PLR.SWING then
  spr(S.PLR.SWING_C,sx,sy-C,0,1,flip)
 elseif spid==S.PLR.HIT then
  spr(S.PLR.HIT_C,
    sx+(Plr.flipped and -C or C),
    sy,0,1,flip)
 end

 -- draw super panda overlay if player
 -- has the super panda powerup
 if Plr.super then
  local osp=Iif3(Plr.atk>0,S.PLR.SUPER_F,
   Plr.swim and not Plr.grounded,
   S.PLR.SUPER_S,
   walking,S.PLR.SUPER_P,S.PLR.SUPER_F)
  spr(osp,sx,Plr.y,0,1,flip)
 end

 -- draw overlays (blinking bamboo and
 -- yellow body) if powerup
 if spid~=S.PLR.SWING and Plr.firePwup>0
   and (time()//128)%2==0 then
  spr(S.PLR.FIRE_BAMBOO,sx,Plr.y,0,1,flip)
 end
 if Plr.firePwup>100 or 
    1==(Plr.firePwup//16)%2 then
  local osp=Iif3(Plr.atk>0,S.PLR.FIRE_F,
   Plr.swim and not Plr.grounded,
   S.PLR.FIRE_S,
   walking,S.PLR.FIRE_P,S.PLR.FIRE_F)
  spr(osp,sx,Plr.y,0,1,flip)
 end

 -- if just respawned, highlight player
 if Game.m==M.PLAY and Plr.dying==0 and
   Plr.respX>=0 and Game.t<100 and
   (Game.t//8)%2==0 then
  rectb(Plr.x-Game.scr-2,Plr.y-2,
    C+4,C+4,15)
 end
end

function RendPlane()
 local ybias=(Game.t//8)%2==0 and 1 or 0

 local sx=Plr.x-Game.scr
 spr(S.AVIATOR,
   sx-C,Plr.y+ybias,0,1,0,0,3,2)
 local spid=(Game.t//4)%2==0 and
   S.AVIATOR_PROP_1 or S.AVIATOR_PROP_2
 spr(spid,sx+C,
   Plr.y+ybias+4,0)
end

function RendHud()
 rect(0,0,SCRW,C,3)

 if Plr.scoreDisp.value~=Plr.score then
  Plr.scoreDisp.value=Plr.score
  Plr.scoreDisp.text=Lpad(Plr.score,6)
 end

 local clr=15

 print(Plr.scoreDisp.text,192,1,clr,true)
 print((Game.m==M.WLD and
   "WORLD MAP" or
   ("LEVEL "..Game.lvl.name)),95,1,7)
 spr(S.PLR.STAND,5,0,0)
 print("x "..Plr.lives,16,1)

 if Plr.plane>0 then
  local barw=PLANE.FUEL_BAR_W
  local lx=120-barw//2
  local y=8
  local clr=(Plr.plane<800 and
    (Game.t//16)%2==0) and 6 or 14
  local clrLo=(clr==14 and 4 or clr)
  print("E",lx-7,y,clr)
  print("F",lx+barw+1,y,14)
  rectb(lx,y,barw,6,clrLo)
  local bw=Plr.plane*
    (PLANE.FUEL_BAR_W-2)//PLANE.MAX_FUEL
  rect(lx+1,y+1,Max(bw,1),4,clr)
  pix(lx+barw//4,y+4,clrLo)
  pix(lx+barw//2,y+4,clrLo)
  pix(lx+barw//2,y+3,clrLo)
  pix(lx+3*barw//4,y+4,clrLo)
 end
end

function RendEnts()
 for i=1,#Ents do
  local e=Ents[i]
  local sx=e.x-Game.scr
  if sx>-C and sx<SCRW then
   spr(e.sprite,sx,e.y,0,1,
     e.flipped and 1 or 0)
  end
 end
end

function RendScrim(sp)
 sp=sp or Iif3(Game.t>45,0,
  Game.t>30,S.SCRIM+2,
  Game.t>15,S.SCRIM+1,
  S.SCRIM)
 for r=0,ROWS-1 do
  for c=0,COLS-1 do
   spr(sp,c*C,r*C,15)
  end
 end
end

-- Render spotlight effect.
-- fc,fr: cell at center of effect
-- t: clock (ticks)
function RendSpotFx(fc,fr,t)
 local rad=Max(0,t//2-2) -- radius
 if rad>COLS then return end
 for r=0,ROWS-1 do
  for c=0,COLS-1 do
   local d=Max(Abs(fc-c),
     Abs(fr-r))
   local sa=d-rad  -- scrim amount
   local spid=Iif2(sa<=0,-1,sa<=3,
     S.SCRIM+sa-1,0)
   if spid>=0 then
    spr(spid,c*C,r*C,15)
   end
  end
 end
end

function RendSign()
 if 0==Plr.signC then return end
 local w=Plr.signC*20
 local h=Plr.signC*3
 local x=SCRW//2-w//2
 local y=SCRH//2-h//2-20
 local s=SIGN_MSGS[Plr.signMsg]
 rect(x,y,w,h,15)
 if Plr.signC==SIGN_C_MAX then
  print(s.l1,x+6,y+8,0)
  print(s.l2,x+6,y+8+C,0)
 end
end

-- Rend tile animations
function RendTanims()
 local c0=Max(0,Game.scr//C)
 local cf=c0+COLS
 for c=c0,cf do
  local anims=Tanims[c]
  if anims then
   for i=1,#anims do
    local r=anims[i]
    local tanim=TANIM[mget(c,r)]
    if tanim then
     local spid=tanim[
       1+(Game.t//16)%#tanim]
     spr(spid,c*C-Game.scr,r*C)
    end
   end
  end
 end
end

--------------------------------------
-- ENTITY BEHAVIORS
---------------------------------------

-- move hit modes: what happens when
-- entity hits something solid.
MOVE_HIT={
 NONE=0,
 STOP=1,
 BOUNCE=2,
 DIE=3,
}

-- aim mode
AIM={
 NONE=0,   -- just shoot in natural
           -- direction of projectile
 HORIZ=1,  -- adjust horizontal vel to
           -- go towards player
 VERT=2,   -- adjust vertical vel to go
           -- towards player
 FULL=3,   -- adjust horiz/vert to aim
           -- at player
}

-- moves horizontally
-- moveDen: every how many ticks to move
-- moveDx: how much to move
-- moveHitMode: what to do on wall hit
-- noFall: if true, flip instead of falling
function BehMove(e)
 if e.moveT>0 then e.moveT=e.moveT-1 end
 if e.moveT==0 then return end
 if e.moveWaitPlr>0 then
  if Abs(Plr.x-e.x)>e.moveWaitPlr then
   return
  else e.moveWaitPlr=0 end
 end
 e.moveNum=e.moveNum+1
 if e.moveNum<e.moveDen then return end
 e.moveNum=0
 
 if e.noFall and
   EntWouldFall(e,e.x+e.moveDx) then
  -- flip rather than fall
  e.moveDx=-e.moveDx
  e.flipped=e.moveDx>0
 elseif e.moveHitMode==MOVE_HIT.NONE or
    EntCanMove(e,e.x+e.moveDx,e.y) then
  e.x=e.x+(e.moveDx or 0)
  e.y=e.y+(e.moveDy or 0)
 elseif e.moveHitMode==MOVE_HIT.BOUNCE
   then
  e.moveDx=-(e.moveDx or 0)
  e.flipped=e.moveDx>0
 elseif e.moveHitMode==MOVE_HIT.DIE then
  e.dead=true
 end
end

-- Moves up/down.
-- e.yamp: amplitude
function BehUpDownInit(e)
 e.maxy=e.y
 e.miny=e.maxy-e.yamp
end

function BehUpDown(e)
 e.ynum=e.ynum+1
 if e.ynum<e.yden then return end
 e.ynum=0
 e.y=e.y+e.dy
 if e.y<=e.miny then e.dy=1 end
 if e.y>=e.maxy then e.dy=-1 end
end

function BehFacePlr(e)
 e.flipped=Plr.x>e.x
 if e.moveDx then
  e.moveDx=Abs(e.moveDx)*
   (e.flipped and 1 or -1)
 end
end

-- automatically flips movement
-- flipDen: every how many ticks to flip
function BehFlip(e)
 e.flipNum=e.flipNum+1
 if e.flipNum<e.flipDen then return end
 e.flipNum=0
 e.flipped=not e.flipped
 e.moveDx=(e.moveDx and -e.moveDx or 0)
end

function BehJump(e)
 if e.jmp==0 then
  e.jmpNum=e.jmpNum+1
  if e.jmpNum<e.jmpDen or
    not e.grounded then return end
  e.jmpNum=0
  e.jmp=1
 else
  -- continue jump  
  e.jmp=e.jmp+1
  if e.jmp>#JUMP_DY then
   -- end jump
   e.jmp=0
  else
   local dy=JUMP_DY[e.jmp]
   if EntCanMove(e,e.x,e.y+dy) then
    e.y=e.y+dy
   else
    e.jmp=0
   end
  end
 end
end

function BehFall(e)
 e.grounded=not EntCanMove(e,e.x,e.y+1)
 if not e.grounded and e.jmp==0 then
  e.y=e.y+1
 end
end

function BehTakeDmg(e,dtype)
 if not ArrayContains(e.dtypes,dtype) then
  return
 end
 e.hp=e.hp-1
 if e.hp>0 then return end
 e.dead=true
 -- drop loot?
 local roll=Rnd(0,99)
 -- give bonus probability to starting
 -- levels (decrease roll value)
 roll=Max(Iif2(Game.lvlNo<2,roll-50,
   Game.lvlNo<4,roll-25,roll),0)
 if roll<e.lootp then
  local i=Rnd(1,#e.loot)
  i=Min(Max(i,1),#e.loot)
  local l=EntAdd(e.loot[i],e.x,e.y-4)
  EntAddBeh(l,BE.MOVE)
  ShallowMerge(l,{moveDy=-1,moveDx=0,
    moveDen=1,moveT=8})
 end
end

function BehPoints(e)
 e.dead=true
 AddScore(e.value or 50,e.x+4,e.y-4)
end

function BehHurt(e)
 HandlePlrHurt()
end

function BehLiftInit(e)
 -- lift top and bottom y:
 local a=C*FetchTile(
   T.META_A,e.x//C)
 local b=C*FetchTile(
   T.META_B,e.x//C)
 if a>b then
  e.boty=a
  e.topy=b
  e.dir=1
 else
  e.topy=a
  e.boty=b
  e.dir=-1
 end 
 e.coll=CR.FULL
end

function BehLift(e)
 e.liftNum=e.liftNum+1
 if e.liftNum<e.liftDen then return end
 e.liftNum=0
 e.y=e.y+e.dir
 if e.dir>0 and e.y>e.boty or 
   e.dir<0 and e.y<e.topy then
  e.dir=-e.dir
 end
end

function BehLiftColl(e)
 -- Lift hit player. Just nudge the player
 Plr.nudgeY=Iif(e.y>Plr.y,-1,1)
end

function BehShootInit(e)
 e.shootNum=Rnd(0,e.shootDen-1)
end

function BehShoot(e)
 e.shootNum=e.shootNum+1
 if e.shootNum<30 then
  e.sprite=e.shootSpr or e.sprite
 end
 if e.shootNum<e.shootDen then return end
 e.shootNum=0
 local shot=EntAdd(
   e.shootEid or EID.FIREBALL,e.x,e.y)
 e.sprite=e.shootSpr or e.sprite
 shot.moveDx=
   Iif(shot.moveDx==nil,0,shot.moveDx)
 shot.moveDy=
   Iif(shot.moveDy==nil,0,shot.moveDy)

 if e.aim==AIM.HORIZ then
  shot.moveDx=(Plr.x>e.x and 1 or -1)*
   Abs(shot.moveDx)
 elseif e.aim==AIM.VERT then
  shot.moveDy=(Plr.y>e.y and 1 or -1)*
   Abs(shot.moveDy)
 elseif e.aim==AIM.FULL then
  local tx=Plr.x-shot.x
  local ty=Plr.y-shot.y
  local mag=math.sqrt(tx*tx+ty*ty)
  local spd=math.sqrt(
    shot.moveDx*shot.moveDx+
    shot.moveDy*shot.moveDy)
  shot.moveDx=math.floor(0.5+tx*spd/mag)
  shot.moveDy=math.floor(0.5+ty*spd/mag)
  if shot.moveDx==0 and shot.moveDy==0 then
   shot.moveDx=-1
  end
 end
end

function BehCrumble(e)
 if not e.crumbling then
  -- check if player on tile
  if Plr.x<e.x-8 then return end
  if Plr.x>e.x+8 then return end
  -- check if player is standing on it
  local pr=RectXLate(
    GetPlrCr(),Plr.x,Plr.y)
  local er=RectXLate(e.coll,e.x,e.y-1)
  e.crumbling=RectIsct(pr,er)
 end

 if e.crumbling then
  -- count down to destruction
  e.cd=e.cd-1
  e.sprite=Iif(e.cd>66,S.CRUMBLE,
    Iif(e.cd>33,S.CRUMBLE_2,S.CRUMBLE_3))
  if e.cd<0 then e.dead=true end
 end
end

function BehTtl(e)
 e.ttl=e.ttl-1
 if e.ttl <= 0 then e.dead = true end
end

function BehDmgEnemy(e)
 local fr=RectXLate(FIRE.COLL,e.x,e.y)
 for i=1,#Ents do
  local ent=Ents[i]
  local er=RectXLate(ent.coll,ent.x,ent.y)
  if e~=ent and RectIsct(fr,er) and
    EntHasBeh(ent,BE.VULN) then
   -- ent hit by player fire
   HandleDamage(ent,Plr.plane>0 and
     DMG.PLANE_FIRE or DMG.FIRE)
   e.dead=true
  end
 end
end

function BehGrantFirePwupColl(e)
 Plr.firePwup=FIRE.DUR
 e.dead=true
 Snd(SND.PWUP)
end

function BehGrantSuperPwupColl(e)
 Plr.super=true
 e.dead=true
 Snd(SND.PWUP)
end

function BehReplace(e)
 local d=Abs(e.x-Plr.x)
 if d<e.replDist then
  EntRepl(e,e.replEid,e.replData)
 end
end

function BehChestInit(e)
 -- ent on top of chest is the contents
 local etop=GetEntAt(e.x,e.y-C)
 if etop then
  e.cont=etop.eid
  etop.dead=true
 else
  e.cont=S.FOOD.LEAF
 end
 -- check multiplier
 e.mul=MetaVal(
  mget(e.x//C,e.y//C-2),1)
 e.open=false
end

function BehChestDmg(e)
 if e.open then return end
 SpawnParts(PFX.POP,e.x+4,e.y+4,14)
 Snd(SND.OPEN);
 e.anim=nil
 e.sprite=S.CHEST_OPEN
 e.open=true
 local by=e.y-C
 local ty=e.y-2*C
 local lx=e.x-C
 local cx=e.x
 local rx=e.x+C
 local c=e.cont
 EntAdd(c,cx,by)
 if e.mul>1 then EntAdd(c,cx,ty) end
 if e.mul>2 then EntAdd(c,lx,by) end
 if e.mul>3 then EntAdd(c,rx,by) end
 if e.mul>4 then EntAdd(c,lx,ty) end
 if e.mul>5 then EntAdd(c,rx,ty) end
end

function BehTplafInit(e)
 e.phase=MetaVal(FetchEntTag(e),0)
end

function BehTplaf(e)
 local UNIT=40     -- in ticks
 local PHASE_LEN=3 -- in units
 local uclk=e.phase+Game.t//UNIT
 local open=((uclk//PHASE_LEN)%2==0)
 local tclk=e.phase*UNIT+Game.t
 e.sprite=Iif2(
  (tclk%(UNIT*PHASE_LEN)<=6),
  S.TPLAF_HALF,open,S.TPLAF,S.TPLAF_OFF)
 e.sol=Iif(open,SOL.HALF,SOL.NOT)
end

function BehDashInit(e)
 assert(EntHasBeh(e,BE.MOVE))
 e.origAnim=e.anim
 e.origMoveDen=e.moveDen
end

function BehDash(e)
 local dashing=e.cdd<e.ddur
 e.cdd=(e.cdd+1)%e.cdur
 if dashing then
  e.anim=e.dashAnim or e.origAnim
  e.moveDen=e.origMoveDen
 else
  e.anim=e.origAnim
  e.moveDen=99999  -- don't move
 end
end

function BehSignInit(e)
 e.msg=MetaVal(FetchEntTag(e),0)
end

function BehSignColl(e)
 Plr.signMsg=e.msg
 -- if starting to read sign, lock player
 -- for a short while
 if Plr.signC==0 then
  Plr.locked=100
 end
 -- increase cycle counter by 2 because
 -- it gets decreased by 1 every frame
 Plr.signC=Min(Plr.signC+2,
   SIGN_C_MAX)
end

function BehOneUp(e)
 e.dead=true
 Plr.lives=Plr.lives+1
 Snd(SND.ONEUP)
end

function BehFlag(e)
 local rx=e.x+C
 if Plr.respX<rx then
  Plr.respX=rx
  Plr.respY=e.y
 end
 Snd(SND.PWUP)
 EntRepl(e,EID.FLAG_T)
end

function BehReplOnGnd(e)
 if e.grounded then
  EntRepl(e,e.replEid,e.replData)
 end
end

function BehPop(e)
 e.dead=true
 SpawnParts(PFX.POP,e.x+4,e.y+4,e.clr)
end

function BehBoardPlane(e)
 e.dead=true
 Plr.plane=PLANE.START_FUEL
 Plr.y=e.y-3*C
 Snd(SND.PLANE)
end

function BehFuel(e)
 e.dead=true
 Plr.plane=Plr.plane+PLANE.FUEL_INC
 Snd(SND.PWUP)
end

---------------------------------------
-- ENTITY BEHAVIORS
---------------------------------------
BE={
 MOVE={
  data={
   -- move denominator (moves every
   -- this many frames)
   moveDen=5,
   moveNum=0, -- numerator, counts up
   -- 1=moving right, -1=moving left
   moveDx=-1,
   moveDy=0,
   moveHitMode=MOVE_HIT.BOUNCE,
   -- if >0, waits until player is less
   -- than this dist away to start motion
   moveWaitPlr=0,
   -- if >=0, how many ticks to move
   -- for (after that, stop).
   moveT=-1,
  },
  update=BehMove,
 },
 FALL={
  data={grounded=false,jmp=0},
  update=BehFall,
 },
 FLIP={
  data={flipNum=0,flipDen=20},
  update=BehFlip,
 },
 FACEPLR={update=BehFacePlr},
 JUMP={
  data={jmp=0,jmpNum=0,jmpDen=50},
  update=BehJump,
 },
 VULN={ -- can be damaged by player
  data={hp=1,
   -- damage types that can hurt this.
   dtypes={DMG.MELEE,DMG.FIRE,DMG.PLANE_FIRE},
   -- loot drop probability (0-100)
   lootp=0,
   -- possible loot to drop (EIDs)
   loot={EID.FOOD.A},
  },
  dmg=BehTakeDmg,
 },
 SHOOT={
  data={shootNum=0,shootDen=100,
   aim=AIM.NONE},
  init=BehShootInit,
  update=BehShoot,
 },
 UPDOWN={
  -- yamp is amplitude of y movement
  data={yamp=16,dy=-1,yden=3,ynum=0},
  init=BehUpDownInit,
  update=BehUpDown,
 },
 POINTS={
  data={value=50},
  coll=BehPoints,
 },
 HURT={ -- can hurt player
  coll=BehHurt
 },
 LIFT={
  data={liftNum=0,liftDen=3},
  init=BehLiftInit,
  update=BehLift,
  coll=BehLiftColl,
 },
 CRUMBLE={
  -- cd: countdown to crumble
  data={cd=50,coll=CR.FULL,crumbling=false},
  update=BehCrumble,
 },
 TTL={  -- time to live (auto destroy)
  data={ttl=150},
  update=BehTtl,
 },
 DMG_ENEMY={ -- damage enemies
  update=BehDmgEnemy,
 },
 GRANT_FIRE={
  coll=BehGrantFirePwupColl,
 },
 REPLACE={
 -- replaces by another ent when plr near
 -- replDist: distance from player
 -- replEid: EID to replace by
  data={replDist=50,replEid=EID.LEAF},
  update=BehReplace,
 },
 CHEST={
  init=BehChestInit,
  dmg=BehChestDmg,
 },
 TPLAF={
  init=BehTplafInit,
  update=BehTplaf,
 },
 DASH={
  data={
   ddur=20, -- dash duration
   cdur=60, -- full cycle duration
   cdd=0, -- cycle counter
  },
  init=BehDashInit,
  update=BehDash,
 },
 GRANT_SUPER={
  coll=BehGrantSuperPwupColl,
 },
 SIGN={
  init=BehSignInit,
  coll=BehSignColl
 },
 ONEUP={coll=BehOneUp},
 FLAG={coll=BehFlag},
 REPL_ON_GND={
  -- replace EID when grounded
  -- replData -- extra data to add to
  data={replEid=EID.LEAF},
  update=BehReplOnGnd
 },
 POP={update=BehPop},
 PLANE={coll=BehBoardPlane},
 FUEL={coll=BehFuel},
}

---------------------------------------
-- ENTITY BEHAVIOR TABLE
---------------------------------------
EBT={
 [EID.EN.SLIME]={
  data={
    hp=1,moveDen=3,clr=11,noFall=true,
    lootp=20,loot={EID.FOOD.A},
  },
  beh={BE.MOVE,BE.FALL,BE.VULN,BE.HURT},
 },

 [EID.EN.HSLIME]={
  data={replDist=50,replEid=EID.EN.SLIME},
  beh={BE.REPLACE},
 },

 [EID.EN.A]={
  data={
    hp=1,moveDen=5,clr=14,flipDen=120,
    lootp=30,
    loot={EID.FOOD.A,EID.FOOD.B},
  },
  beh={BE.MOVE,BE.JUMP,BE.FALL,BE.VULN,
   BE.HURT,BE.FLIP},
 },
 
 [EID.EN.B]={
  data={
    hp=1,moveDen=5,clr=13,
    lootp=30,
    loot={EID.FOOD.A,EID.FOOD.B,
      EID.FOOD.C},
  },
  beh={BE.JUMP,BE.FALL,BE.VULN,BE.HURT,
    BE.FACEPLR},
 },

 [EID.EN.DEMON]={
  data={hp=1,moveDen=5,clr=7,
   aim=AIM.HORIZ,
   shootEid=EID.FIREBALL,
   shootSpr=S.EN.DEMON_THROW,
   lootp=60,
   loot={EID.FOOD.C,EID.FOOD.D}},
  beh={BE.JUMP,BE.FALL,BE.SHOOT,
   BE.HURT,BE.FACEPLR,BE.VULN},
 },

 [EID.EN.SDEMON]={
  data={hp=1,moveDen=5,clr=7,
   flipDen=50,
   shootEid=EID.SNOWBALL,
   shootSpr=S.EN.SDEMON_THROW,
   aim=AIM.HORIZ,
   lootp=75,
   loot={EID.FOOD.C,EID.FOOD.D}},
  beh={BE.JUMP,BE.FALL,BE.SHOOT,
   BE.MOVE,BE.FLIP,BE.VULN,BE.HURT},
 },

 [EID.EN.PDEMON]={
  data={hp=1,clr=11,flipDen=50,
   shootEid=EID.PLASMA,
   shootSpr=S.EN.PDEMON_THROW,
   aim=AIM.FULL,
   lootp=80,
   loot={EID.FOOD.D}},
  beh={BE.JUMP,BE.FALL,BE.SHOOT,
   BE.FLIP,BE.VULN,BE.HURT},
 },

 [EID.EN.BAT]={
  data={hp=1,moveDen=2,clr=9,flipDen=60,
    lootp=40,
    loot={EID.FOOD.A,EID.FOOD.B}},
  beh={BE.MOVE,BE.FLIP,BE.VULN,BE.HURT},
 },
 
 [EID.EN.FISH]={
  data={
    hp=1,moveDen=3,clr=9,flipDen=120,
    lootp=40,
    loot={EID.FOOD.A,EID.FOOD.B},
  },
  beh={BE.MOVE,BE.FLIP,BE.VULN,
   BE.HURT},
 },
  
 [EID.EN.FISH2]={
  data={hp=1,clr=12,moveDen=1,
   lootp=60,
   loot={EID.FOOD.B,EID.FOOD.C}},
  beh={BE.MOVE,BE.DASH,BE.VULN,BE.HURT},
 },

 [EID.FIREBALL]={
  data={hp=1,moveDen=2,clr=7,
    coll=CR.BALL,
    moveHitMode=MOVE_HIT.DIE},
  beh={BE.MOVE,BE.HURT,BE.TTL},
 },

 [EID.PLASMA]={
  data={hp=1,moveDen=2,clr=7,
    moveDx=2,
    coll=CR.BALL,
    moveHitMode=MOVE_HIT.NONE},
  beh={BE.MOVE,BE.HURT,BE.TTL},
 },

 [EID.SNOWBALL]={
  data={hp=1,moveDen=1,clr=15,
    coll=CR.BALL,
    moveHitMode=MOVE_HIT.DIE},
  beh={BE.MOVE,BE.FALL,BE.VULN,BE.HURT},
 },

 [EID.LIFT]={
  data={sol=SOL.FULL},
  beh={BE.LIFT},
 },

 [EID.CRUMBLE]={
  data={
   sol=SOL.FULL,clr=14,
   -- only take melee and plane fire dmg
   dtypes={DMG.MELEE,DMG.PLANE_FIRE},
  },
  beh={BE.CRUMBLE,BE.VULN},
 },

 [EID.PFIRE]={
  data={
   moveDx=1,moveDen=1,ttl=80,
   moveHitMode=MOVE_HIT.DIE,
   coll=FIRE.COLL,
  },
  beh={BE.MOVE,BE.TTL,BE.DMG_ENEMY},
 },

 [EID.FIRE_PWUP]={
  beh={BE.GRANT_FIRE},
 },

 [EID.SPIKE]={
  data={coll=CR.FULL},
  beh={BE.HURT},
 },
 
 [EID.CHEST]={
  data={coll=CR.FULL,
   sol=SOL.FULL},
  beh={BE.CHEST},
 },

 [EID.TPLAF]={
  data={sol=SOL.HALF,
   coll=CR.TOP},
  beh={BE.TPLAF},
 },
 
 [EID.EN.DASHER]={
  data={hp=1,clr=12,moveDen=1,noFall=true,
   dashAnim={S.EN.DASHER,315},
   lootp=60,
   loot={EID.FOOD.B,EID.FOOD.C}},
  beh={BE.MOVE,BE.DASH,BE.VULN,BE.HURT},
 },
 
 [EID.EN.VBAT]={
  data={hp=1,clr=14,yden=2,
    lootp=40,
    loot={EID.FOOD.B,EID.FOOD.C}},
  beh={BE.UPDOWN,BE.VULN,BE.HURT},
 },

 [EID.SUPER_PWUP]={beh={BE.GRANT_SUPER}},
 [EID.SIGN]={beh={BE.SIGN}},
 [EID.FLAG]={beh={BE.FLAG}},
 
 [EID.ICICLE]={
  data={replEid=EID.ICICLE_F,replDist=8},
  beh={BE.REPLACE},
 },

 [EID.ICICLE_F]={
  data={replEid=EID.POP,replData={clr=15}},
  beh={BE.FALL,BE.HURT,BE.REPL_ON_GND}
 },

 [EID.SICICLE]={
  data={replEid=EID.SICICLE_F,replDist=8},
  beh={BE.REPLACE},
 },

 [EID.SICICLE_F]={
  data={replEid=EID.POP,replData={clr=14}},
  beh={BE.FALL,BE.HURT,BE.REPL_ON_GND}
 },

 [EID.POP]={beh={BE.POP}},
 [EID.PLANE]={beh={BE.PLANE}},
 [EID.FUEL]={beh={BE.FUEL}},
 
 [EID.FOOD.LEAF]={
   data={value=50,coll=CR.FOOD},
   beh={BE.POINTS}},
 [EID.FOOD.A]={
   data={value=100,coll=CR.FOOD},
   beh={BE.POINTS}},
 [EID.FOOD.B]={
   data={value=200,coll=CR.FOOD},
   beh={BE.POINTS}},
 [EID.FOOD.C]={
   data={value=500,coll=CR.FOOD},
   beh={BE.POINTS}},
 [EID.FOOD.D]={
   data={value=1000,coll=CR.FOOD},
   beh={BE.POINTS}}, 
}

---------------------------------------
-- DEBUG MENU
---------------------------------------
function DbgTic()
 if Plr.dbgResp then
  cls(1)
  print(Plr.dbgResp)
  if btnp(4) then
   Plr.dbgResp=nil
  end
  return
 end

 Game.dbglvl=Game.dbglvl or 1

 if btnp(3) then
  Game.dbglvl=Iif(Game.dbglvl+1>#LVL,1,Game.dbglvl+1)
 elseif btnp(2) then
  Game.dbglvl=Iif(Game.dbglvl>1,Game.dbglvl-1,#LVL)
 end

 local menu={
  {t="(Close)",f=DbgClose},
  {t="Warp to test lvl",f=DbgWarpTest}, 
  {t="Warp to L"..Game.dbglvl,f=DbgWarp},
  {t="End lvl",f=DbgEndLvl},
  {t="Grant super pwup",f=DbgSuper},
  {t="Fly mode "..
    Iif(Plr.dbgFly,"OFF","ON"),f=DbgFly},
  {t="Invuln mode "..
    Iif(Plr.invuln and Plr.invuln>0,
        "OFF","ON"),
    f=DbgInvuln},
  {t="Unpack L"..Game.dbglvl,f=DbgUnpack},
  {t="Pack L"..Game.dbglvl,f=DbgPack},
  {t="Clear PMEM",f=DbgPmem},
  {t="Win the game",f=DbgWin}, 
  {t="Lose the game",f=DbgLose}, 
 }
 cls(5)
 print("DEBUG")

 rect(110,0,140,16,11)
 print("DBG LVL:",120,4,3)
 print(LVL[Game.dbglvl].name,170,4)

 Plr.dbgSel=Plr.dbgSel or 1
 for i=1,#menu do
  print(menu[i].t,10,10+i*10,
   Plr.dbgSel==i and 15 or 0)
 end
 if btnp(0) then
  Plr.dbgSel=Iif(Plr.dbgSel>1,
   Plr.dbgSel-1,#menu)
 elseif btnp(1) then
  Plr.dbgSel=Iif(Plr.dbgSel<#menu,
   Plr.dbgSel+1,1)
 elseif btnp(4) then
  (menu[Plr.dbgSel].f)()
 end
end

function DbgClose() Plr.dbg=false end

function DbgSuper() Plr.super=true end

function DbgEndLvl()
 EndLvl()
 Plr.dbg=false
end

function DbgPmem() pmem(0,0) end

function DbgWarp()
 StartLvl(Game.dbglvl)
end

function DbgWarpNext()
 StartLvl(Game.lvlNo+1)
end

function DbgWarpTest()
 StartLvl(#LVL)
end

function DbgUnpack()
 UnpackLvl(Game.dbglvl,UMODE.EDIT)
 sync()
 Plr.dbgResp="Unpacked & synced L"..Game.dbglvl
end

function DbgPack()
 local succ=PackLvl(Game.dbglvl)
 --MapClear(0,0,LVL_LEN,ROWS)
 sync()
 Plr.dbgResp=Iif(succ,
   "Packed & synced L"..Game.dbglvl,
   "** ERROR packing L"..Game.dbglvl)
end

function DbgFly()
 Plr.dbgFly=not Plr.dbgFly
 Plr.dbgResp="Fly mode "..Iif(Plr.dbgFly,
  "ON","OFF")
end

function DbgInvuln()
 Plr.invuln=Iif(Plr.invuln>0,0,9999999)
 Plr.dbgResp="Invuln mode "..Iif(
  Plr.invuln>0,"ON","OFF")
end

function DbgWin()
 SetMode(M.WIN)
 Plr.dbg=false
end

function DbgLose()
 SetMode(M.GAMEOVER)
 Plr.dbg=false
end

---------------------------------------
-- UTILITIES
---------------------------------------
function Iif(cond,t,f)
 if cond then return t else return f end
end

function Iif2(cond,t,cond2,t2,f2)
 if cond then return t end
 return Iif(cond2,t2,f2)
end

function Iif3(cond,t,cond2,t2,cond3,t3,f3)
 if cond then return t end
 return Iif2(cond2,t2,cond3,t3,f3)
end

function Iif4(cond,t,cond2,t2,cond3,t3,
   cond4,t4,f4)
 if cond then return t end
 return Iif3(cond2,t2,cond3,t3,cond4,t4,f4)
end

function ArrayContains(a,val)
 for i=1,#a do
  if a[i]==val then return true end
 end
 return false
end

function Lpad(value, width)
 local s=value..""
 while string.len(s) < width do
  s="0"..s
 end
 return s
end

function RectXLate(r,dx,dy)
 return {x=r.x+dx,y=r.y+dy,w=r.w,h=r.h}
end

-- rects have x,y,w,h
function RectIsct(r1,r2)
 return
  r1.x+r1.w>r2.x and r2.x+r2.w>r1.x and
  r1.y+r1.h>r2.y and r2.y+r2.h>r1.y
end

function DeepCopy(t)
 if type(t)~="table" then return t end
 local r={}
 for k,v in pairs(t) do
  if type(v)=="table" then
   r[k]=DeepCopy(v)
  else
   r[k]=v
  end
 end
 return r
end

-- if preserve, fields that already exist
-- in the target won't be overwritten
function ShallowMerge(target,src,
  preserve)
 if not src then return end
 for k,v in pairs(src) do
  if not preserve or not target[k] then
   target[k]=DeepCopy(src[k])
  end
 end
end

function MapCopy(sc,sr,dc,dr,w,h)
 for r=0,h-1 do
  for c=0,w-1 do
   mset(dc+c,dr+r,mget(sc+c,sr+r))
  end
 end
end

function MapClear(dc,dr,w,h)
 for r=0,h-1 do
  for c=0,w-1 do
   mset(dc+c,dr+r,0)
  end
 end
end

function MapColsEqual(c1,c2,r)
 for i=0,ROWS-1 do
  if mget(c1,r+i)~=mget(c2,r+i) then
   return false
  end
 end
 return true
end

function MetaVal(t,deflt)
 return Iif(
  t>=T.META_NUM_0 and t<=T.META_NUM_0+12,
  t-T.META_NUM_0,deflt)
end

-- finds marker m on column c of level
-- return row of marker, -1 if not found
function FetchTile(m,c,nowarn)
 for r=0,ROWS-1 do
  if LvlTile(c,r)==m then
   if erase then SetLvlTile(c,r,0) end
   return r
  end
 end
 if not nowarn then
  trace("Marker not found "..m.." @"..c)
 end
 return -1
end

-- Gets the entity's "tag marker",
-- that is the marker tile that's sitting
-- just above it. Also erases it.
-- If no marker found, returns 0
function FetchEntTag(e)
 local t=mget(e.x//C,e.y//C-1)
 if t>=T.FIRST_META then
  mset(e.x//C,e.y//C-1,0)
  return t
 else
  return 0
 end
end

function Max(x,y) return math.max(x,y) end
function Min(x,y) return math.min(x,y) end
function Abs(x,y) return math.abs(x,y) end
function Rnd(lo,hi) return math.random(lo,hi) end
function Rnd01() return math.random() end
function RndSeed(s) return math.randomseed(s) end
function Ins(tbl,e) return table.insert(tbl,e) end
function Rem(tbl,e) return table.remove(tbl,e) end
function Sin(a) return math.sin(a) end
function Cos(a) return math.cos(a) end


-- <TILES>
-- 001:5b5b5b5b55555555494449444444444444494494444444444944944944444444
-- 002:4449444944444444494449444444444444494494444444444944944944444444
-- 003:aaaaaaaa73733737773373377337337773733737773373377337337777777777
-- 004:9999999949494949000000000000000000000000000000000000000000000000
-- 005:7777777777777777777777777777777777777777777777777777777777777777
-- 006:7373737377777777373373333333333333373373333333333733733733333333
-- 007:3337333733333333373337333333333333373373333333333733733733333333
-- 008:3333333377377377333333337377377333333333377377373333333377377377
-- 009:7777777777777777777777777777777777777777777777777777777777777777
-- 010:7777777777777777777777777777777777777777777777777777777777777777
-- 011:7777777777777777777777777777777777777777777777777777777777777777
-- 012:0000000007700000007000000070000000700000077700000000000000000000
-- 013:0000000000000000090909094949494949494949090909090000000000000000
-- 014:0000000000000000000000004444444444444444000000000000000000000000
-- 015:0000000000000000000000003333333333333333000000000000000000000000
-- 016:d22d2d222dd2d2dd222222222222222222222222222222222222222222222222
-- 017:bebebebebbbbbbbb5b555b5555555555555b55b5555555555b55b55b55555555
-- 018:555b555b555555555b555b5555555555555b55b5555555555b55b55b55555555
-- 019:eeeeeeee49499494449949944994994449499494449949944994994444444444
-- 020:7777777777777777777777777777777777777777777777777777777777777777
-- 021:7777777777777777777777777777777777777777777777777777777777777777
-- 022:7777777777777777777777777777777777777777777777777777777777777777
-- 023:7777777777777777777777777777777777777777777777777777777777777777
-- 024:7777777777777777777777777777777777777777777777777777777777777777
-- 025:7777777777777777777777777777777777777777777777777777777777777777
-- 026:7777777777777777777777777777777777777777777777777777777777777777
-- 027:7777777777777777777777777777777777777777777777777777777777777777
-- 028:0000000007770000000700000777000007000000077700000000000000000000
-- 029:7777777777777777777777777777777777777777777777777777777777777777
-- 030:0004400000044000000440000004400000044000000440000004400000044000
-- 031:0003300000033000000330000003300000033000000330000003300000033000
-- 032:2222222222222222222222222222222222222222222222222222222222222222
-- 033:dfdfdfdfddddddddafaafaaaaaaaaaaaaaafaafaaaaaaaaaafaafaafaaaaaaaa
-- 034:aaafaaafaaaaaaaaafaaafaaaaaaaaaaaaafaafaaaaaaaaaafaafaafaaaaaaaa
-- 035:ffffffffdadaadadddaadaaddaadaadddadaadadddaadaaddaadaadddddddddd
-- 036:7777777777777777777777777777777777777777777777777777777777777777
-- 037:7777777777777777777777777777777777777777777777777777777777777777
-- 038:7777777777777777777777777777777777777777777777777777777777777777
-- 039:7777777777777777777777777777777777777777777777777777777777777777
-- 040:7777777777777777777777777777777777777777777777777777777777777777
-- 041:7777777777777777777777777777777777777777777777777777777777777777
-- 042:7777777777777777777777777777777777777777777777777777777777777777
-- 043:7777777777777777777777777777777777777777777777777777777777777777
-- 044:0000000007770000000700000077000000070000077700000000000000000000
-- 046:0004400004444440044444404444444444444444044444400444444000044000
-- 047:0003300003333330033333303333333333333333033333300333333000033000
-- 048:22222d2222222d222d222d222d2222222d2d222d222d222d222d222d22222222
-- 049:4949494944444444efeefeeeeeeeeeeeeeefeefeeeeeeeeeefeefeefeeeeeeee
-- 050:eeefeeefeeeeeeeeefeeefeeeeeeeeeeeeefeefeeeeeeeeeefeefeefeeeeeeee
-- 051:99999999e4e44e4eee44e44ee44e44eee4e44e4eee44e44ee44e44eeeeeeeeee
-- 052:ffffffffe33ee33e33ee33ee3ee33ee3ee33ee33e33ee33e33ee33ee3ee33ee3
-- 053:7777777777777777777777777777777777777777777777777777777777777777
-- 054:7777777777777777777777777777777777777777777777777777777777777777
-- 055:7777777777777777777777777777777777777777777777777777777777777777
-- 056:7777777777777777777777777777777777777777777777777777777777777777
-- 057:7777777777777777777777777777777777777777777777777777777777777777
-- 058:7777777777777777777777777777777777777777777777777777777777777777
-- 059:7777777777777777777777777777777777777777777777777777777777777777
-- 060:0000000007070000070700000777000000070000000700000000000000000000
-- 061:066666606333f336633ff3366333f3366333f3366333f336633fff3606666660
-- 062:0666666063fff33663333f366333f336633f333663f3333663ffff3606666660
-- 063:0666666063fff33663333f36633ff33663333f3663333f3663fff33606666660
-- 064:7777777777777777777777777777777777777777777777777777777777777777
-- 065:7777777777777777777777777777777777777777777777777777777777777777
-- 066:7777777777777777777777777777777777777777777777777777777777777777
-- 067:7777777777777777777777777777777777777777777777777777777777777777
-- 068:7777777777777777777777777777777777777777777777777777777777777777
-- 069:7777777777777777777777777777777777777777777777777777777777777777
-- 070:7777777777777777777777777777777777777777777777777777777777777777
-- 071:7777777777777777777777777777777777777777777777777777777777777777
-- 072:7777777777777777777777777777777777777777777777777777777777777777
-- 073:7777777777777777777777777777777777777777777777777777777777777777
-- 074:7777777777777777777777777777777777777777777777777777777777777777
-- 075:7777777777777777777777777777777777777777777777777777777777777777
-- 076:0000000007770000070000000777000000070000077700000000000000000000
-- 077:0000000003003303030300030303330303000303030330030000000000000000
-- 078:0000000000033300000300000003300000030000330333000000000000000000
-- 079:0666666063ffff3663f3333663fff33663f3333663f3333663f3333606666660
-- 080:4449444944444444494449444444444444494494444444444944944944444444
-- 081:aaaaaaaa73733737773373377337337773733737773373377337333777777777
-- 082:000000000000000000000000000000ff0fffffff000000000000000000000000
-- 083:0000000000000000ffffffffffffffffffffffff000000000000000000000000
-- 084:0000000000000000fffff000ffffff00fffffff000fffff00ffffff000ffff00
-- 085:000000000000005b00000555000000550000005500000005bbbbb00055555bb0
-- 086:0000000000000000bbbbbbb0555555505555555b555555550001100000010000
-- 087:000000000000007f00000777000000770000007700000007fffff00077777ff0
-- 088:0000000000000000fffffff0777777707777777f777777770007700000070000
-- 089:00bbbb0b0b5555b5b5bbbb550b555515b5555010b55000100500001000000010
-- 090:bbb00000555b0000bbb5b000555b00005555b0000055b0000005000000000000
-- 091:7777777777777777777777777777777777777777777777777777777777777777
-- 092:0000000007770000070000000777000007070000077700000000000000000000
-- 093:777777707fffff737777f773777f777377f777737fffff737777777303333333
-- 094:000000007000000007777777066666ee006666ee000600ee0006000066666666
-- 095:000000000000000777777770ee666660ee666600ee0060000000600066666666
-- 096:0000000000000000000000b000b0b05b0b505b5505505555b55b555555555555
-- 097:000000000000000000b00000b05b0b005055050b5b5505b55555b55555555555
-- 098:0000000000000000000000000000000000007700000333700033333703333333
-- 099:0003700000333700033333700034430000333300000330000003300000033000
-- 101:0055555000001000000011000000011100000111000011110001111100111111
-- 102:0011000001100000111000001100000010000000100000000000000000000000
-- 103:0077777000007000000077000000077700000777000077770007777700777777
-- 104:0077000007700000777000007700000070000000700000000000000000000000
-- 105:000000100000011000000110000001000000010000001100000011000001100b
-- 106:0000000000000000000b0b00000505000b05b5b005b55550b555555b55555555
-- 107:7777777777777777777777777777777777777777777777777777777777777777
-- 108:7777777777777777777777777777777777777777777777777777777777777777
-- 109:777777707f777f7377f7f773777f777377f7f7737f777f737777777303333333
-- 110:0066666600060000000600000006000000660000006600000066000000660000
-- 111:6666660000006000000060000000600000006600000066000000660000006600
-- 112:7777777777777777777777777777777777777777777777777777777777777777
-- 113:7777777777777777777777777777777777777777777777777777777777777777
-- 114:7777777777777777777777777777777777777777777777777777777777777777
-- 115:7777777777777777777777777777777777777777777777777777777777777777
-- 116:7777777777777777777777777777777777777777777777777777777777777777
-- 117:7777777777777777777777777777777777777777777777777777777777777777
-- 118:7777777777777777777777777777777777777777777777777777777777777777
-- 119:7777777777777777777777777777777777777777777777777777777777777777
-- 120:7777777777777777777777777777777777777777777777777777777777777777
-- 121:7777777777777777777777777777777777777777777777777777777777777777
-- 122:7777777777777777777777777777777777777777777777777777777777777777
-- 123:7777777777777777777777777777777777777777777777777777777777777777
-- 124:77777770777f777377fff7737f7f7f73777f7773777f77737777777303333333
-- 125:000f0000000f0000000f0000000f0000000f0000000f0000000f0000000f0000
-- 126:0000000090000000099999990eeeee4400eeee44000e0044000e0000eeeeeeee
-- 127:00000000000000099999999044eeeee044eeee004400e0000000e000eeeeeeee
-- 128:00000000000000b000b00b500b50b550000b550000b550000b55000000000000
-- 129:0e0000006e0e000e0e0e006e0e6e0e0e6e0e0e0e0e0e0e6e0e6e6e0e0e0e0e0e
-- 130:0c000000dc0c000c0c0c00dc0cdc0c0cdc0c0c0c0c0c0cdc0cdcdc0c0c0c0c0c
-- 131:7777777777777777777777777777777777777777777777777777777777777777
-- 132:0000000000040000e0044000eeeeeee0999eeeee000440000004000000000000
-- 133:0000000000000000000000000666666000ffff0000ffff000000000000000000
-- 134:0000000000000000000009900999990000ffff9000ffff000000000000000000
-- 135:00000000000000000ee5eee00ee5eee000f5ff0000f5ff000000000000000000
-- 136:0000000000000000000ff00000ffff000ffffff00ff77ff000f77f0000000000
-- 137:7777777777777777777777777777777777777777777777777777777777777777
-- 138:7777777777777777777777777777777777777777777777777777777777777777
-- 139:77777770777f777377f777737fffff7377f77773777f77737777777303333333
-- 140:77777770777f7773777f77737f7f7f7377fff773777f77737777777303333333
-- 141:77777770777f77737777f7737fffff737777f773777f77737777777303333333
-- 142:00eeeeee000e0000000e0000000e000000ee000000ee000000ee000000ee0000
-- 143:eeeeee000000e0000000e0000000e0000000ee000000ee000000ee000000ee00
-- 144:7777777777777777777777777777777777777777777777777777777777777777
-- 145:7777777777777777777777777777777777777777777777777777777777777777
-- 146:7777777777777777777777777777777777777777777777777777777777777777
-- 147:7777777777777777777777777777777777777777777777777777777777777777
-- 148:7777777777777777777777777777777777777777777777777777777777777777
-- 149:7777777777777777777777777777777777777777777777777777777777777777
-- 150:7777777777777777777777777777777777777777777777777777777777777777
-- 151:7777777777777777777777777777777777777777777777777777777777777777
-- 152:7777777777777777777777777777777777777777777777777777777777777777
-- 153:7777777777777777777777777777777777777777777777777777777777777777
-- 154:7777777777777777777777777777777777777777777777777777777777777777
-- 155:7777777777777777777777777777777777777777777777777777777777777777
-- 156:7777777777777777777777777777777777777777777777777777777777777777
-- 157:7777777777777777777777777777777777777777777777777777777777777777
-- 158:7777777777777777777777777777777777777777777777777777777777777777
-- 159:7777777777777777777777777777777777777777777777777777777777777777
-- 160:7777777777777777777777777777777777777777777777777777777777777777
-- 161:7777777777777777777777777777777777777777777777777777777777777777
-- 162:7777777777777777777777777777777777777777777777777777777777777777
-- 163:7777777777777777777777777777777777777777777777777777777777777777
-- 164:7777777777777777777777777777777777777777777777777777777777777777
-- 165:7777777777777777777777777777777777777777777777777777777777777777
-- 166:7777777777777777777777777777777777777777777777777777777777777777
-- 167:7777777777777777777777777777777777777777777777777777777777777777
-- 168:7777777777777777777777777777777777777777777777777777777777777777
-- 169:7777777777777777777777777777777777777777777777777777777777777777
-- 170:7777777777777777777777777777777777777777777777777777777777777777
-- 171:7777777777777777777777777777777777777777777777777777777777777777
-- 172:7777777777777777777777777777777777777777777777777777777777777777
-- 173:7777777777777777777777777777777777777777777777777777777777777777
-- 174:7777777777777777777777777777777777777777777777777777777777777777
-- 175:7777777777777777777777777777777777777777777777777777777777777777
-- 176:0e0000e000eeee000e6e6ee00e6e6ee000eeee0000eeee0000eeee000e0ee0e0
-- 177:0d0000d00dddddd0006d6d00006d6d00dddddddd000dd00000d00d000d0000d0
-- 178:060006000666660000e6e99000e6e9e906666699000660000006600000600600
-- 179:000000000000000000990000009e900000099000000000000000000000000000
-- 180:000000000b0000b000bbbb000b6b6bb00b6b6bb000bbbb0000bbbb000bbbbbb0
-- 181:00000000090000900099990000e9e90090e9e909999999990909909000000000
-- 182:0000000000000000000000000000000000000000000000000b0000b000bbbb00
-- 183:0c0000c000cccc000cececc00cececc000cccc00000cc00000cccc000c0000c0
-- 184:000000000e0000e000eeee00006e6e00e06e6e0eeeeeeeee0e0ee0e000000000
-- 185:0d000d000ddddd00006d6ff0006d6fdf0dddddff000dd000000dd00000d00d00
-- 186:000000000ddd00000dddd0000ddfdd0000dddd00000ddd000000000000000000
-- 187:ddddddd0ddfffdd00dfffd000dfffd0000dfd00000dfd000000d0000000d0000
-- 188:050505000555550000e5ecc000e5ecfc055555cc005555000055550000500500
-- 189:00000000009900090e9990999e99999099999990099990990099000900000000
-- 190:cc00000000cc000c0eccc0ccceccccc0ccccccc00cccc0cc00cc000c00000000
-- 191:7777777777777777777777777777777777777777777777777777777777777777
-- 192:eeeeeeee373737373333333373737373333333333737373733333333eeeeeeee
-- 193:eeeeeeee499e94944e99e9e449e9999449e949e444ee9994494e9e4499999999
-- 194:000f0000000f000000a7f00000a7f0000a777f000a777f00a77777f0aaaaaaa0
-- 195:000ee00000e00e000e0000e00eeeeee00e4ee4e00e4ee4e00e4444e00eeeeee0
-- 196:eeeeeeee9e9e9e9e000000000000000000000000000000000000000000000000
-- 197:44444440444f4440444f444044444440444f4440444444400004000000040000
-- 198:0900000009990000093399990933333909993339090099990900000099900000
-- 199:9999999099eee99009eee90009eee900009e9000009e90000009000000090000
-- 200:04440000400040eeeeeeeee0e999ee00e9eeee0ee99ee000e9eee000eeeee000
-- 201:7777777777777777777777777777777777777777777777777777777777777777
-- 202:7777777777777777777777777777777777777777777777777777777777777777
-- 203:7777777777777777777777777777777777777777777777777777777777777777
-- 204:7777777777777777777777777777777777777777777777777777777777777777
-- 205:7777777777777777777777777777777777777777777777777777777777777777
-- 206:7777777777777777777777777777777777777777777777777777777777777777
-- 207:7777777777777777777777777777777777777777777777777777777777777777
-- 208:7777777777777777777777777777777777777777777777777777777777777777
-- 209:7777777777777777777777777777777777777777777777777777777777777777
-- 210:7777777777777777777777777777777777777777777777777777777777777777
-- 211:7777777777777777777777777777777777777777777777777777777777777777
-- 212:7777777777777777777777777777777777777777777777777777777777777777
-- 213:7777777777777777777777777777777777777777777777777777777777777777
-- 214:7777777777777777777777777777777777777777777777777777777777777777
-- 215:7777777777777777777777777777777777777777777777777777777777777777
-- 216:7777777777777777777777777777777777777777777777777777777777777777
-- 217:7777777777777777777777777777777777777777777777777777777777777777
-- 218:7777777777777777777777777777777777777777777777777777777777777777
-- 219:7777777777777777777777777777777777777777777777777777777777777777
-- 220:7777777777777777777777777777777777777777777777777777777777777777
-- 221:7777777777777777777777777777777777777777777777777777777777777777
-- 222:7777777777777777777777777777777777777777777777777777777777777777
-- 223:7777777777777777777777777777777777777777777777777777777777777777
-- 224:7777777777777777777777777777777777777777777777777777777777777777
-- 226:7777777777777777777777777777777777777777777777777777777777777777
-- 227:7777777777777777777777777777777777777777777777777777777777777777
-- 228:7777777777777777777777777777777777777777777777777777777777777777
-- 229:7777777777777777777777777777777777777777777777777777777777777777
-- 230:7777777777777777777777777777777777777777777777777777777777777777
-- 231:7777777777777777777777777777777777777777777777777777777777777777
-- 232:7777777777777777777777777777777777777777777777777777777777777777
-- 233:7777777777777777777777777777777777777777777777777777777777777777
-- 234:7777777777777777777777777777777777777777777777777777777777777777
-- 235:7777777777777777777777777777777777777777777777777777777777777777
-- 236:7777777777777777777777777777777777777777777777777777777777777777
-- 237:7777777777777777777777777777777777777777777777777777777777777777
-- 238:7777777777777777777777777777777777777777777777777777777777777777
-- 239:7777777777777777777777777777777777777777777777777777777777777777
-- 240:0000000000066600006006000060060000600600006666000000000006666660
-- 241:0000000000006000000660000000600000006000000060000000000006666660
-- 242:0000000000066600000006000066660000600000006666000000000006666660
-- 243:0000000000066600000006000066660000000600006666000000000006666660
-- 244:0000000000000600006006000066660000000600000006000000000006666660
-- 245:0000000000666000006000000066660000000600006666000000000006666660
-- 246:0000000000600000006000000066660000600600006666000000000006666660
-- 247:0000000000666600000006000000060000000600000006000000000006666660
-- 248:0000000000066600006006000066660000600600006666000000000006666660
-- 249:0000000000066600006006000066660000000600006666000000000006666660
-- 250:0000000006066660660600600606006006060060060666600000000006666660
-- 251:0000000000060060006606600006006000060060000600600000000006666660
-- 252:0000000006006660660000600606666006060000060666600000000006666660
-- 253:7777777777777777777777777777777777777777777777777777777777777777
-- 254:000ee00000e00e0000e00e0000eeee0000e00e0000e00e00000000000eeeeee0
-- 255:00eee00000e00e0000eee00000e00e0000e00e0000eeee00000000000eeeeee0
-- </TILES>

-- <SPRITES>
-- 000:7777777777777777777777777777777777777777777777777777777777777777
-- 001:0030030000ffff0000fcfc0000ffff000333333330ffff00003ff30000300300
-- 002:00030030000ffff0000fcfc0000ffff00333333300ffff00033ff30000000000
-- 003:0030030000ffff0000fcfc0000ffff000333333600ffff00003ff30000300300
-- 004:000000000000000000000000000000000000000000000000000b00000000b000
-- 005:7777777777777777777777777777777777777777777777777777777777777777
-- 006:0000000e0000000e0000000e0000000e000000000000000e0000000000000000
-- 007:00000000e6e00000000000000000000000000000000000000000000000000000
-- 008:0e000000060000000e0000000000000000000000000000000000000000000000
-- 009:000000000066660000e0e000006666000000000000eeee00000ee00000000000
-- 010:000000000006660000ee0e00006666000000000000eeee0000eee00000000000
-- 011:00030300000fff0000ff3f0000ffff00003333300ffff0000fff000030030000
-- 012:00030300000fff0000ff3f0000ffff00003333000ffff0000fff000003300000
-- 013:7777777777777777777777777777777777777777777777777777777777777777
-- 014:7777777777777777777777777777777777777777777777777777777777777777
-- 015:7777777777777777777777777777777777777777777777777777777777777777
-- 016:7777777777777777777777777777777777777777777777777777777777777777
-- 017:0030030b00ffff0b00f3f30b00ffff0b0333333330ffff0b003ff30003003000
-- 018:0030030000777700007373000077770003333330307777030037730000300300
-- 019:7777777777777777777777777777777777777777777777777777777777777777
-- 020:00300b0000ffffb000f3f30300ffff300333330030ffff00003ff30000300300
-- 021:0030030000ffff0000f3f30000ffff000333333330ffffb0003ff30000300300
-- 022:0000000000b000000b000000b000000000000000000000000000000000000000
-- 023:00000000000ccc000ccccc000ccfcc000cccc0c00ccc000000000c0000000000
-- 024:000000000fff0ff00ffff0000ffcff0000ffff00000fff000f00000000000000
-- 025:0000000000cccc0000f0f00000cccc000000000000cccc00000cc00000000000
-- 026:00000000000ccc0000ff0f0000cccc000000000000cccc0000ccc00000000000
-- 027:00000000000ccc0000ff0f0000cccc00000000000cccc0000ccc000000000000
-- 028:000000000006660000ee0e0000666600000000000eeee0000eee000000000000
-- 029:7777777777777777777777777777777777777777777777777777777777777777
-- 030:7777777777777777777777777777777777777777777777777777777777777777
-- 031:7777777777777777777777777777777777777777777777777777777777777777
-- 032:00000000000000f000b00f500b50f550000b550000b550000b55000000000000
-- 033:00000000000000b000b00b500b50b550000f550000f550000f55000000000000
-- 034:0e0000e000eeee000e6e6ee00e6e6ee000eeee0000eeee0000eeee0000eeee00
-- 035:000000000d0000d00dddddd0006d6d00006d6d00dddddddd000dd0000dd00dd0
-- 036:060006000666660000e6e60000e6e990066669e9000666990006600000600600
-- 037:060006000666660000e6e60600e6e66006666600000666000006600000600600
-- 038:000000000000000000099000009e900000990000000000000000000000000000
-- 039:0b0000b000bbbb000b6b6bb00b6b6bb000bbbb0000bbbb000bbbbbb0bbbbbbbb
-- 040:00000000090000900099990000e9e90000e9e900099999909909909990000009
-- 041:00000000000000000000000000000000000000000b0000b000bbbb000b6b6bb0
-- 042:000000000e0000e000eeee00006e6e00006e6e000eeeeee0ee0ee0eee000000e
-- 043:0d000d000ddddd00006d6d00006d6ff00ddddfdf000dddff000dd00000d00d00
-- 044:0d000d000ddddd00006d6d0d006d6dd00ddddd00000ddd00000dd00000d00d00
-- 045:00000000000fff0000ffff000ffdff000ffff0000fff00000000000000000000
-- 046:ddfffdd00dfffd000dfffd0000dfd00000dfd000000d0000000d000000000000
-- 047:0d00f000ddf000d00dfff0000dfffd0000dfd00000dfd000000d0000000d0000
-- 048:e0e0e0e0090e04044090e0e00909090440e040e0040e09044040904009090909
-- 049:e0e0e0e0000000004090e0e00000000040e040e0000000004040904000000000
-- 050:0e0000006e0e000e0e0e006e0e6e0e0eff0f0f0f0f0f0fff0fffff0f0f0f0f0f
-- 051:0f000000ff0f000f0f0f00ff0fff0f0fff0f0f0f0e0e0e6e0e6e6e0e0e0e0e0e
-- 052:00000000000f0000000f000000a7f00000a7f0000a777f000a777f00a77777f0
-- 053:000ee00000e44e000e4444e00eeeeee00e4ee4f00e4ef4f00e4444f00eeffff0
-- 054:000ff00000f44f000f4444e00ffffee00f4fe4e00f4ee4e00f4444e00eeeeee0
-- 055:0004400000000400000000400444444004344340043443400433334004444440
-- 056:0999999000999900000000000000000000000000000000000000000000000000
-- 057:0009900000000000000000000000000000000000000000000000000000000000
-- 058:000000000c0000c000cccc000cececc00cececc000cccc00000cc0000cccccc0
-- 059:0c0000c000cccc000cececc00cececc000cccc00000cc00000cccc00000cc000
-- 060:050005000555550000e5e50000e5ecc005555cfc005555cc0055550000500500
-- 061:050005000555550000e5e50500e5e55005555500005555000055550005000500
-- 062:99eee99009eee90009eee900009e9000009e9000000900000009000000000000
-- 063:0900e00099e0009009eee00009eee900009e9000009e90000009000000090000
-- 064:0c000000dc0c000c0c0c00dc0cdc0c0cff0f0f0f0f0f0fff0fffff0f0f0f0f0f
-- 065:0f000000ff0f000f0f0f00ff0fff0f0fdc0c0c0c0c0c0cdc0cdcdc0c0c0c0c0c
-- 066:0000000000000000000ff00000ffff000fffffe00ff77e9000f7790000000000
-- 067:0000000000000000000ff00000ffe9000ffe9ff00fe77ff000977f0000000000
-- 068:0000000000000000000e900000e9ff000e9ffff009f77ff000f77f0000000000
-- 069:0900999909993339093333390933999909990000090000000900000099900000
-- 070:0b0000000bb7bb7b0bbffffb0bbf7f7b0bbffffb0bbbbbbb0b000000bbb00000
-- 071:0000000000040000e0044000eeeefff0999eefff000440000004000000000000
-- 072:0000000000040000e0044000efffeee099fffeee000440000004000000000000
-- 073:0000000000040000f0044000ffeeeee0fffeeeee000440000004000000000000
-- 074:04440000400040efeeeeeef0e999ef00e9eeff00e99ff00ee9fff000effff000
-- 075:0eee0000e000e0eeffffffe0f999fe00f9ffee00f99fe000f9eee000feeee00e
-- 076:2d22d2ddd2dd2d22222222222222222222222222222222222222222222222222
-- 077:222d222d2222222222222d2222222d222d222d222d2222222d2d222d222d222d
-- 078:2d2d222d222d222d222d222d2222222222222d2222222d222d222d222d222222
-- 079:2d222d222d2222222d2d222d222d222d222d222d2222222222222d2222222d22
-- 080:00000000000000000e0000000e0000000ee000000eee00000eeeeeee9999999e
-- 081:000000000000030300000f99000044940000ffff00003333ee90ffffeee99999
-- 082:000000000000000000000000000000000f0000003f00000009e000009eee0000
-- 083:00000f0000000f0000000f0000000f0000000e0000000e0000000e0000000e00
-- 084:00000000000000000000000000000f0000000e00000000000000000000000000
-- 085:7777777777777777777777777777777777777777777777777777777777777777
-- 086:7777777777777777777777777777777777777777777777777777777777777777
-- 087:7777777777777777777777777777777777777777777777777777777777777777
-- 088:7777777777777777777777777777777777777777777777777777777777777777
-- 089:7777777777777777777777777777777777777777777777777777777777777777
-- 090:7777777777777777777777777777777777777777777777777777777777777777
-- 091:7777777777777777777777777777777777777777777777777777777777777777
-- 092:7777777777777777777777777777777777777777777777777777777777777777
-- 093:7777777777777777777777777777777777777777777777777777777777777777
-- 094:7777777777777777777777777777777777777777777777777777777777777777
-- 095:7777777777777777777777777777777777777777777777777777777777777777
-- 096:000eeeee0000eeee00000eee000000330000003f000000330000000000000000
-- 097:eeeeeeee999999eeeeeeeeee3eeeee333000003f000000330000000000000000
-- 098:eeeee000eeee0000ee0000003000000030000000300000000000000000000000
-- 099:7777777777777777777777777777777777777777777777777777777777777777
-- 100:7777777777777777777777777777777777777777777777777777777777777777
-- 101:7777777777777777777777777777777777777777777777777777777777777777
-- 102:7777777777777777777777777777777777777777777777777777777777777777
-- 103:7777777777777777777777777777777777777777777777777777777777777777
-- 104:7777777777777777777777777777777777777777777777777777777777777777
-- 105:7777777777777777777777777777777777777777777777777777777777777777
-- 106:7777777777777777777777777777777777777777777777777777777777777777
-- 107:7777777777777777777777777777777777777777777777777777777777777777
-- 108:7777777777777777777777777777777777777777777777777777777777777777
-- 109:7777777777777777777777777777777777777777777777777777777777777777
-- 110:7777777777777777777777777777777777777777777777777777777777777777
-- 111:7777777777777777777777777777777777777777777777777777777777777777
-- 112:00000000009900000e9990999e99999999999999099990990099000000000000
-- 113:0cc0000000cc00000eccc0c0cecccccccccccccc0cccc0c000cc000000000000
-- 114:0000000000000000777777777777777777777777777777777777777777777777
-- 115:7777777777777777777777777777777777777777777777777777777777777777
-- 116:7777777777777777777777777777777777777777777777777777777777777777
-- 117:7777777777777777777777777777777777777777777777777777777777777777
-- 118:7777777777777777777777777777777777777777777777777777777777777777
-- 119:7777777777777777777777777777777777777777777777777777777777777777
-- 120:7777777777777777777777777777777777777777777777777777777777777777
-- 121:7777777777777777777777777777777777777777777777777777777777777777
-- 122:7777777777777777777777777777777777777777777777777777777777777777
-- 123:7777777777777777777777777777777777777777777777777777777777777777
-- 124:7777777777777777777777777777777777777777777777777777777777777777
-- 125:7777777777777777777777777777777777777777777777777777777777777777
-- 126:7777777777777777777777777777777777777777777777777777777777777777
-- 127:7777777777777777777777777777777777777777777777777777777777777777
-- 128:7777777777777777777777777777777777777777777777777777777777777777
-- 129:7777777777777777777777777777777777777777777777777777777777777777
-- 130:7777777777777777777777777777777777777777777777777777777777777777
-- 131:7777777777777777777777777777777777777777777777777777777777777777
-- 132:7777777777777777777777777777777777777777777777777777777777777777
-- 133:7777777777777777777777777777777777777777777777777777777777777777
-- 134:7777777777777777777777777777777777777777777777777777777777777777
-- 135:7777777777777777777777777777777777777777777777777777777777777777
-- 136:7777777777777777777777777777777777777777777777777777777777777777
-- 137:7777777777777777777777777777777777777777777777777777777777777777
-- 138:7777777777777777777777777777777777777777777777777777777777777777
-- 139:7777777777777777777777777777777777777777777777777777777777777777
-- 140:7777777777777777777777777777777777777777777777777777777777777777
-- 141:7777777777777777777777777777777777777777777777777777777777777777
-- 142:7777777777777777777777777777777777777777777777777777777777777777
-- 143:7777777777777777777777777777777777777777777777777777777777777777
-- 144:7777777777777777777777777777777777777777777777777777777777777777
-- 145:7777777777777777777777777777777777777777777777777777777777777777
-- 146:7777777777777777777777777777777777777777777777777777777777777777
-- 147:7777777777777777777777777777777777777777777777777777777777777777
-- 148:7777777777777777777777777777777777777777777777777777777777777777
-- 149:7777777777777777777777777777777777777777777777777777777777777777
-- 150:7777777777777777777777777777777777777777777777777777777777777777
-- 151:7777777777777777777777777777777777777777777777777777777777777777
-- 152:7777777777777777777777777777777777777777777777777777777777777777
-- 153:7777777777777777777777777777777777777777777777777777777777777777
-- 154:7777777777777777777777777777777777777777777777777777777777777777
-- 155:7777777777777777777777777777777777777777777777777777777777777777
-- 156:7777777777777777777777777777777777777777777777777777777777777777
-- 157:7777777777777777777777777777777777777777777777777777777777777777
-- 158:7777777777777777777777777777777777777777777777777777777777777777
-- 159:7777777777777777777777777777777777777777777777777777777777777777
-- 160:7777777777777777777777777777777777777777777777777777777777777777
-- 161:7777777777777777777777777777777777777777777777777777777777777777
-- 162:7777777777777777777777777777777777777777777777777777777777777777
-- 163:7777777777777777777777777777777777777777777777777777777777777777
-- 164:7777777777777777777777777777777777777777777777777777777777777777
-- 165:7777777777777777777777777777777777777777777777777777777777777777
-- 166:7777777777777777777777777777777777777777777777777777777777777777
-- 167:7777777777777777777777777777777777777777777777777777777777777777
-- 168:7777777777777777777777777777777777777777777777777777777777777777
-- 169:7777777777777777777777777777777777777777777777777777777777777777
-- 170:7777777777777777777777777777777777777777777777777777777777777777
-- 171:7777777777777777777777777777777777777777777777777777777777777777
-- 172:7777777777777777777777777777777777777777777777777777777777777777
-- 173:7777777777777777777777777777777777777777777777777777777777777777
-- 174:7777777777777777777777777777777777777777777777777777777777777777
-- 175:7777777777777777777777777777777777777777777777777777777777777777
-- 176:7777777777777777777777777777777777777777777777777777777777777777
-- 177:7777777777777777777777777777777777777777777777777777777777777777
-- 178:7777777777777777777777777777777777777777777777777777777777777777
-- 179:7777777777777777777777777777777777777777777777777777777777777777
-- 180:7777777777777777777777777777777777777777777777777777777777777777
-- 181:7777777777777777777777777777777777777777777777777777777777777777
-- 182:7777777777777777777777777777777777777777777777777777777777777777
-- 183:7777777777777777777777777777777777777777777777777777777777777777
-- 184:7777777777777777777777777777777777777777777777777777777777777777
-- 185:7777777777777777777777777777777777777777777777777777777777777777
-- 186:7777777777777777777777777777777777777777777777777777777777777777
-- 187:7777777777777777777777777777777777777777777777777777777777777777
-- 188:7777777777777777777777777777777777777777777777777777777777777777
-- 189:7777777777777777777777777777777777777777777777777777777777777777
-- 190:7777777777777777777777777777777777777777777777777777777777777777
-- 191:7777777777777777777777777777777777777777777777777777777777777777
-- 192:7777777777777777777777777777777777777777777777777777777777777777
-- 193:7777777777777777777777777777777777777777777777777777777777777777
-- 194:7777777777777777777777777777777777777777777777777777777777777777
-- 195:7777777777777777777777777777777777777777777777777777777777777777
-- 196:7777777777777777777777777777777777777777777777777777777777777777
-- 197:7777777777777777777777777777777777777777777777777777777777777777
-- 198:7777777777777777777777777777777777777777777777777777777777777777
-- 199:7777777777777777777777777777777777777777777777777777777777777777
-- 200:7777777777777777777777777777777777777777777777777777777777777777
-- 201:7777777777777777777777777777777777777777777777777777777777777777
-- 202:7777777777777777777777777777777777777777777777777777777777777777
-- 203:7777777777777777777777777777777777777777777777777777777777777777
-- 204:7777777777777777777777777777777777777777777777777777777777777777
-- 205:7777777777777777777777777777777777777777777777777777777777777777
-- 206:7777777777777777777777777777777777777777777777777777777777777777
-- 207:0bbbbbb0b333333bb33333bbb3333b3bb3b3b33bb33b333bb333333b0bbbbbb0
-- 208:7777777777777777777777777777777777777777777777777777777777777777
-- 209:7777777777777777777777777777777777777777777777777777777777777777
-- 210:7777777777777777777777777777777777777777777777777777777777777777
-- 211:7777777777777777777777777777777777777777777777777777777777777777
-- 212:7777777777777777777777777777777777777777777777777777777777777777
-- 213:7777777777777777777777777777777777777777777777777777777777777777
-- 214:7777777777777777777777777777777777777777777777777777777777777777
-- 215:7777777777777777777777777777777777777777777777777777777777777777
-- 216:7777777777777777777777777777777777777777777777777777777777777777
-- 217:7777777777777777777777777777777777777777777777777777777777777777
-- 218:7777777777777777777777777777777777777777777777777777777777777777
-- 219:7777777777777777777777777777777777777777777777777777777777777777
-- 220:7777777777777777777777777777777777777777777777777777777777777777
-- 221:7777777777777777777777777777777777777777777777777777777777777777
-- 222:7777777777777777777777777777777777777777777777777777777777777777
-- 223:7777777777777777777777777777777777777777777777777777777777777777
-- 224:0000000000000000070007007070707070707070707070700700070000000000
-- 225:0000000000000000777007007000707077007070007070707700070000000000
-- 226:0000000000000000000077000000070000000700000007000000777000000000
-- 227:0000000000000000000077000000007000000700000070000000777000000000
-- 228:0000000000000000000077000000007000000700000000700000770000000000
-- 229:0000000000000000000070000000707000007770000000700000007000000000
-- 230:0000000000000000000077700000700000007700000000700000770000000000
-- 231:0000000000000000000007700000700000007700000070700000770000000000
-- 232:0000000000000000000077700000007000000700000007000000070000000000
-- 233:0000000000000000000007000000707000000700000070700000070000000000
-- 234:0000000000000000000007000000707000000770000000700000770000000000
-- 235:0000000000000000070007007700707007007070070070707770070000000000
-- 236:7777777777777777777777777777777777777777777777777777777777777777
-- 237:7777777777777777777777777777777777777777777777777777777777777777
-- 238:7777777777777777777777777777777777777777777777777777777777777777
-- 239:7777777777777777777777777777777777777777777777777777777777777777
-- 240:0000000800000088000008880000888800088888008888880888888888888888
-- 241:8888888888888888888888888888888888888888888888888888888888888888
-- 242:0f0f0f0fffffffff0f0f0f0fffffffff0f0f0f0fffffffff0f0f0f0fffffffff
-- 243:0f0f0f0ff0f0f0f00f0f0f0ff0f0f0f00f0f0f0ff0f0f0f00f0f0f0ff0f0f0f0
-- 244:00000000f0f0f0f000000000f0f0f0f000000000f0f0f0f000000000f0f0f0f0
-- 245:7777777777777777777777777777777777777777777777777777777777777777
-- 246:7777777777777777777777777777777777777777777777777777777777777777
-- 247:7777777777777777777777777777777777777777777777777777777777777777
-- 248:7777777777777777777777777777777777777777777777777777777777777777
-- 249:7777777777777777777777777777777777777777777777777777777777777777
-- 250:7777777777777777777777777777777777777777777777777777777777777777
-- 251:7777777777777777777777777777777777777777777777777777777777777777
-- 252:7777777777777777777777777777777777777777777777777777777777777777
-- 253:7777777777777777777777777777777777777777777777777777777777777777
-- 254:7777777777777777777777777777777777777777777777777777777777777777
-- 255:7777777777777777777777777777777777777777777777777777777777777777
-- </SPRITES>

-- <MAP>
-- 017:4f0000002f3f0000005f2f4f00000000000000000000af0000007f3f2f9f00000000002f00002f3f2f3f00002f002f002f002f2f2f2f2f2f2f2f002f000000002f00002f00000000000000003f2f002f007f002f0000000000003f00af0000002f3f2f6f2f6f00002f006f00006f004f002f4f0000003f2f006f009f002f00007f00000000000000af005f6f00af0000005f2f5f00006f006f4f2f9f004f0000005f4f3f3f0000002f00002f0000002f00002f0000000000000000000000005f002f2f002f002f0000003f0000003f2f2f0000004f00002f002f000000002f2f002f2f5f002f00000000000000000000
-- 018:0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000000000000000000000000800000000005b000000000000000020000000000000000000000000000000000000000000200000000000000000000000000000080018005b0000000000000000000000000000000000200000000008000000ff00ef00ff0000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 019:00000000000000000000000000000000000000000000000000000000000000000008000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000080000000020000000000000000000000000ef00080008002800000000000000006b000010000000066c006b000000200000550000005b000000000000000000000000000020000000000000000000000000000008003c00000000000000000000002b00000000000000206c0000003c00080000000c00000008080808080800000000000000000000000000000000000000000000000000000000000000000000
-- 020:0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002000000000000000000000000000000000001b3c000000000000001010001020101010101010100000002000000000000006061600000000000000000000000020000000000000000000000000000030303030303040303030303030303030301c00000028204030003030000800000000000000003606005b0000000000000000000000000055000000000000000000e50000000000000000000000
-- 021:000000000000000000000000000000000000000000000000000000000000000000004b001b000000000000000000000000000000080000000800000800000000000000000000002f000000000000efefef000000200000000000000000000000000000100010101000000000000040202000200000000000000020000000204010101010101010101000000000000000000000002000000000000000000000000000000000000000000030000000000000000000000000003c2000302c300000080000000000000010101010101000000000000000000000060600002b00000000000000000000000000000000000000
-- 022:00000000000000000000000000000000000000000000000000000000000008000000101010100000000000080000000000000000080000000000000000000000000008080000005800000000000000000000e50020000000000000000000000000000020002020200000000000000020200020006f000000000020000000200000000000000000002000000000000055000000002000000000000000000000000000000000000000004030000008080008080008080000303020403030300000080000000000000020202020202000000000000000004000101010101010001c001c0030303000000000000000000000
-- 023:0000000000000000000000000000000000000000000000000000000000000000001020202020003000000008000000000000000000000000000000006c00001b000000000000003c000000360600000000000000200000000000000000000000000000200020202000000000000040202000200058000000000020085b00204000000000000000002000000000006b000000000020000000000000000000000000000000000000000000300000000000000000000000000000200000000000000800000000000c0020202020202000000000000000000000202020202020000000000000000000000000000000000000
-- 024:00000000000000000000000000000000000000000000000000000000080000001020202020200000001000000000000000000000400000001000101010104010004b00064b1010104010101010100c0c0c10101020000000000000000000000000000020002020200000000000000020200020003c1b40000000200000002000001b001b000000002000000000101010101010002000000000000000000000000000000000000000004030003030300030300030300000000020400000000000000000000000000020202020202000000000000000004000202020202020000000000000000000000000000000000000
-- 025:000000000000000000000000000000002f000000000000000000080000000010202020202020000000200000000000000000000000000000200000000000402010101010102020004000200000000000002020202000000000000000000000000000002000202020000000000000402020002010101000002f0020101000201010101010100000402000001c000000000000000020000000000000001800000000000000000000001c1c3000302c2c2c2c2c2c2c2c2c2c2c2c20000055000000000000000000000020202020202000000000000000000000202020202020000000000000000000000000000000000000
-- 026:000000000000000000000000000000005c000058687800550000000000001020202020202020000000200008000000000000000040000030200000000000400000000000000000004000200000000000002020202000000000000000000000000000002000202020000000080800002020002020202040000800000000002000000000000000000020003000000000000000000020000000000800004000000000000000001c1c1c0000300030303030303030303030303030004000000000062b0000000000000020202020202000300000000000004000202020202020000000000000000000000000000000000000
-- 027:000000000000000000000800000000313131313131310056004b001010102020202020202020000000200008000000000800000000000000200000000000400000000000000000004000200000000000002020202000000000000000000000000000002000202020000000000000402020002020202000003c000000000620000000000000000040200000000000000000000000200000000000000000000000550000001c000000000030000000000000000000000000000000000010101010100000000000000020202020202000000000000000000000202020202020000000000000000000000000000000000000
-- 028:0000000000080000000000000000102020202020202010101010102000202020202020202020000000200000000000550000000040003000200000006f00400008080808080808084000206f000000000020202020000000000000000000000000000020002020200036005500000020200020202020400010101010101020000000000000000000200000000000000000000000200000ef000000004000000000006b1c000000000000300055000000000000000000000b000000102020202020000c000800080020202020202000000000000000004000050000000020000000000000000000000000000000000000
-- 029:00ef00000000000055000000001020202020202020202020202020200020202020202020202000000020000f00000056001b0000000000002000000058004000000000000078000040002000580000000020202020000000000000ef00550000000c0020002020200010004b4b00102020002020202000000000000000000000000000000000004020000000000000000000000020001010101c10000000000010101000000000000000300000001616166b6b0000002636000010202020202020000000080008002020202020200000000000000000000005006f000020000000000000000000000000000000000000
-- 030:000000160000003656000000102020202020202020202020202020200020202020202020202000000020005c002800101010003030300000200000003c0040100010100010100000400020005800000000202020200000000000161616560b1b00000020002020200020101010102020200020202020000000000008000000000000000000000000200000000000e500000000002000202020002000400000102020200000000000000030101010101010101010101010101010202020202020200000000000000020202020202000000000550000004000050068000020000000000000000000000000000000000000
-- 031:1010101010101010101000102020202020202020202020202020202000202020202020202020000000201010101010202020000000000000200010101000002000202000202000000000200010000000002020202000000000001010101010100000002000202020002020202020202020002020202000001f000000000000000000000000000040200000000000e6001b00000020002020200020000000102020202000000000000000302020202020202020202020202020202020202020202000000000000000202020202020000000280000066b6b0005003c000020000000000000000000000000000000000000
-- 032:202020202020202020200020202020202020202020202020202020200020202020202020202000000020202020202020202000000000000020002020200000200020200020200000000020002000ffffff2020202000000000002020202020200000002000202020002020202020202020002020202016005c061800000000000000006b6b6b6b0020000000000010101010001020002020202c201c1c1c202020202000000000000000302020202020202020202020202020202020202020202000ef00ff00ef0020202020202000000010101010101000101010101020000000000000000000000000000000000000
-- 033:20202020202020202020102020202020202020202020202020202020002020202020202020200000002020202020202020200000000000002000202020000020002020002020000000002000200000000020202020000000000020202020202000ff002000202020002020202020202020002020202010101010101c1c10101010101010101010102000000000002020202000202000202020202000000020202020200000000000000030202020202020202020202020202020202020202020200000000000000020202020202000000000000000000000000000000000000000000000000000000000000000000000
-- 034:2f004f00005f006f2f2f00000000000000002f0000000000000000000000002f00002f000000007f00002f002f002f4f3f002f00008f0000008f002f002f002f00af0000000000002f002f000000002f00002f2f0000000000000000000000005f000000005f00000000005f000000004f00000000004f0000002f2f00004f000000000000000000000000006f00002f000000000000000000000000000000002f3f4f000000000000002f000000002f002f000000000000000000000000000000000000002f0000002f3f00000000000000000000000000000000002f00000000000000000000000000000000000000
-- 035:0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000e5000000000000001800000000000000000000002800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 036:00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000031000028000000000000000000000000000000002b000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003c00000000000000000000003c000000000000000000000000000000000000000000000000000000000000000000000000003100006f00000000003100000000000000000000000000002c00002c0000000000000000
-- 037:0000000000000000000000000000000000000018000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003100003c000000000000007b000000000011111111000000000000000000000000000000000000000000006c0000000000000000000000000000000000000000000000000000000000000000004c0011111100004000001c310000000000000000000000313100000000000000000000000000000000000000000000000000000000000000000000ff0031000058002800002b310000000000000000000000403131313131313100280000000000
-- 038:000000000000000000000000000000000000003c0000080008000800000000000000000000000000000000000000000000000000000000000000000000000000000031003131313131313131313131313131000000002100000000000000000000000000000008004000111111111111000000000000000000000000000008007800000000000000000000000000001f00002100000000312c2c312c2c31000000000000000000004000000000000000000000000000000000000000000000000000000000000000000000000031003c003c0000310000000000000000000000000000000000000031003c0000000000
-- 039:000000000000000000000000000000000000003030003000300030000000000000000000000000000000000000000000000000000000000000000000000000000000314000000000000000000000000000310000185b2100000000000000000000000000000008000000212121212121000000000000000000001f0000001b003c00000000000000000000000000004c000021000000403131313131313100000000000000000000000000000000000800000000000000000000000000000000000000000000000000000000000031313131313100000000000000000000000000400000000000000031310000000000
-- 040:000000000000000000000000000000002f00000000000000000000004c00000000000000000000000000000000000000000000000000000000000000000000000000310000005b00000000005b000000003100003c00210000000000ef00280000000000000008004000000000000021000000000000000000004c00111111111100000000000000000000000000002f0000210000000000000000000000000000ff1c0008080808400000000000002f00000000000000000000000000000000000000006b00000000000000000000000000000000000000550000000000000000000000000000000000000000000000
-- 041:0000000000000000000000000000000068000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003131314c4c314c314c313131313100310011111121000000000000003c0000000000000008000000000000000021000000000000000000002f00002121210000000000000000000000000000004c00002100000040000000000000000000000000000000007b6b0008000808004c00000000000000000000002f000000000000111111000000000000000000000000000000000000000000007b000000005b400000000000000000000000000000
-- 042:000000000000000000000008000000003c00000000000000000000004c00000000000000000000000000ff000000000000000000000000000000000000000000000000000000000000000000000000004031002121212100000011111111110000000000000008004000000000180021000000080808080000004c0000002100000000000000000000000000002b003f00002100000000000000000000000000000000001111111111000f003f3f000f00080008080808000055007800000000002c2121210000000000000000000000000000003f000011111111110011111111110000000000000000000000000000
-- 043:000000000000000008000000003131313131000000000000000000000000000000000000000000000000000000000000004f0000000000000000000000000000000000000000000000000000000000000000002100000000000000212121000000005b0000000800000000002b3c0021007b00000000002b00003f000000210000000000000000001c1c00111111004c00002100000040000000000000000000000000000021212100004c1c4c4c1c4c1c3f0000000000006c00003c0000000011112121210000000000000000000000000000004c000000212121000000212121000000000000000000000000000000
-- 044:00000000000000000000004c0000000000001c1c1c1c1c1c1c1c1c003131004c0031313131000000000000003f002f0000580000000000000000000000000000000800000000000000000000000055004000002100000000000000002100000000000000000008004000111111110021111111401111111111004c000000210000000000001c1c0000004000210000000000210000000000000000000000000000000000000021000000000000000000004c001c1c1c1c001111111111008b112121212121001c001c000c0000550000002800004f000000002100000000002100000000000000000000000000000000
-- 045:00000000000055006b0000000000000000000000000000000000000000000000000008000000000000000c004c004c00003c000000000000000000000000000000000000002f2f001f000000000000006b00002100000000000000002100005b00000000000008000000212121210021000000000021212100000000000021000000313100000000000000002100000000002100000040ef000000000000000000000000000021000000000000000000000000000000000000212121008b0000000021000000000000000000000000002b3c00004c000000002100000000002100000000008800000000000000000000
-- 046:0000000000000000114000000000000000000000000000000000000000000000000008000000550000000000000000001111110000000000000000000000000000111111004c4c004c004c000011111111110021e5000000000000002100000000000000000008004000002121210000006f0040000021000000000000002100000000000000000000004000210000000000210000000000003100001b00002b0000000000002100000000000000000000000000000000000000210000000000000021000000000000000000111111111111110000000000002100000000002100000000003c00000000000000000000
-- 047:000000002600111121000000000000000000000000000000000000000000000000000800000000002b00000000000000212121000000000000000000001f004c00212121000000000000000000212121212100210000000000000000210000000000000000001b000000000021000000000800000000210000000000000021000000000000000000000000002100000000002100000031313131000031313131000c00000000210000000000000000000000000000000000000021000000000000002100000000000000000000212121212100000000000000210000000000210000001c1c3100000000e50000000000
-- 048:00ef0011111121212140002800550000000000000000000000000000000000000000112c11111111110000000000000021212100550000281b00002f004c00000021212100000000000000000021212121212c211111110000000000210000111111008b111111004000000021000000003c00400000210000000000000021001800000000000000000040002100000000002100000000000000000000000000000000000000210000000000000000000000000000000000000021000000000000002100000000000000ef000000002100000000000000000021000000000021000000000000002c2c00000000000000
-- 049:11111121212121212100003c260000000000000000000000000000000000000000002121212121212100ef00000000002121216c00000b3c1111004c00000000002121210000000000000000002121212121212121212100000000002100000021000000002100000000000021001111111111000000210000000000000021003c00001c00001c00001c0000210000000000210000000000000000000000000000ef000000002100000000000000000000000000000000000000210000000000000021000000000000000000000000210000000000000000002100000000002100000000000000111111111100000000
-- 050:212121212121212121111111111111000000000000000000000000000000000000002121212121212100000000000000212121111111111121210000000000000021212100000000000000000021212121212121212121000000000021000000210000000021000000000000210000212121000000002100000000000000210011112c2c2c2c2c2c2c2c2c0021000000000021000000000000000000000000000000000000002100000000000000000000000000000000000000210000000000000021000000000000000000000000210000000000000000002100000000002100000000000000002121210000000000
-- 051:3f002f002f2f4f0000002f2f00002f2f2f2f00002f000000000000000000000000000000002f00000000000000000000000000000000000000002f000000002f002f4f002f002f002f0000000000002f0000000000000000000000000000000000003f007f7f000000000000000000007f0000006f000000000000002f2f004f004f00003f6f00004f00007f2f8f2f008f000000000000004f2f2f00000000000000000000002f002f00000000000000004f0000002f0000000000000000000000000000000000000000000000000000000000002f002f002f002f006f00000000000000000000000000000000000000
-- 052:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000032009b00000000000000006c00000000000000320000000000000000000000000000000000000000000022323232323232320000003200000000000000000000320000000000000000000000000028000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 053:0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003c000000000000000000000000000000000000000000000000000000000000000000000000002800000000000000001800003232323200000000000000323200002800000032000000000000000000000000000000000000000000002232323232323232000000320000000000000000000032006f0000000000000000006c003c000000003232320000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 054:00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000012000000000000000000000032000000000000ff0000000000000000000000000000000000000000000000000000000000003c00000000000000003c00003200000000000000004000000000003c000000320018000000000000000000000000000000000000000022000000bb000000000000320000000000000000000032005800001c001c0000001c3232323200000000003200000000000000000000000000006b000000000f004f002f000f000000080000000000000000000000000000000000
-- 055:00000000000000000000000000000000000000000000000000000000009b0000000000000000000000000000002200280000000000000000000040009b0000000000000000000000000000000000000000000000000000000000000000004032000800000000321c323240324040404040404000000000008b323200320032003c00324000000000000000000000000000000000002200000000002800000000320000000000000000000032003c00002c2c2c2c2c2c2c320000000000000000320000000000000000000032321c3232003232004c004c004c004c0032001c0000000000000000000000000000000000
-- 056:00000000000000000000000000000000000000000000000000000000323232000000000000000000000000000022003c0000000000000000000000323232000000000000000000000000000000000000e5000000000000000000000000000000000800000000322c320000320000000000000000000000000032008b000000323232000000000000000000000000000000000000002200000000003c00000000320000000000000000000032323200003232323232323232000000000040002b32000000000000ffffff0032320832324032320000000000000000003200000008000000000000000000000000000000
-- 057:00000000000000009b000000000000000000000000000000000000000000000000000000000075000000000000224032000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004000000800000000323232004032400808080808080808000000003200000000000000000040000000000000000000000000000000000022000000000040400000003200006f0000000000000032320040000000000000000032000000004000323232000000000000000000003232083232083232000000000000000000320000001c000000000000000000000000000000
-- 058:0000000000000032323200000000000000000000000000000000000000000000000000006b0000004b005b00002200000000000000000000000000000000000000000000000000000000000000004032323200000000000000000000000000000008000000000000000000323232323232323232323200000032000000000000000000000000000000000000000000000000e500002200ef0000000000001c00328800780000000000000032320000000000000000000032000000400000000032009b000000000008000032320832324032320000000000000000003200000000000800000000000000000000000000
-- 059:0000000000000000000000000000000000000000000000000000000000000000000000001212121212121212002240000000000000000000000000007500000000000000000000000000000000000000000000000000000000000000000040000008000000000000000040320000000000000000000000400032000000000000000000400000750000369b0000000036001b000000220000000800000b000000323c003c8b000000000000323200409b00000000000000320000400000000000323232320000000008000032320832320832320000000000000000003200000000001c00000000000000000000000000
-- 060:00000000000000000000000000000000000000000000000000000000000000000000001222000000000000000022000000000000000000000000003600000000000000000000000000000000000040000000000000000000000000ef750000000008000000000000000000320000000000000000000000000032000000000000000000000000009b00121212001c001212121212402232323232323232000800323232323232000000000032323232323232323200ff0032004000000000002b320000000000000008000032320832324032320000000000000000003200000000000000080000000000000000000000
-- 061:000000000000000000000000000000000000000008080808080800000000000000001222220008087b00080800224000000000000000000000001212121212000c00006b00000000000000000000000000000000006f000000000000000040000008007500000000000040320000007500000000002b004000320000001c1c1212007b4000001212122222220000002222222222002232323232323232000800000000009b0000080000000000000000bbbb00000000003240000000000032323200000000000000080000323208323208323200000000000000000032000000000000001c00000000000000e5000000
-- 062:0000000000000875080808000828000000000000000000007b000000000000000012222222001212121212121212000000000000000000001c0022222222220000001212006b00000000000000004000000000000078000000001212121200000000007b000000000000000000000000002b00121212000000320000000000222212121200122222222222220000002222222222402232323232323232000800000000323232001c00000000000000000000000000000032004000000000000032000000000000000800003232083232403232000000000000000000322c2c2c2c2c2c2c2c2c00000000000000000000
-- 063:00ef00750000000000000000003c000000000000121212121212001c1c1c1c1c002222222200000000000000000040000000000000001c000000222222222200000022221212006b007500000000000000000000003c0000000022222222121212121212120000005b004000000000121212122222220000000000000000002222222222002222222222222200000022222222220022323232323232320008000000000000000000000800000000000000000000000000320000400000000000323232323200000008000032000800000800320000000000000000003232323232323232323200000000323232323200
-- 064:0000000000001212121212003232003200320000002f0022222200000000000000222222220000000000000000000075000000001c000000000022222222220000002222222212120000005b00004000121c1c1c1c120000000022222222222222222222221212001c00121212000022222222222222000000000000000000222222222200222222222222220000000000006f004022323232323232320008000000000000000000001c0000000000000000000000000032080808400000002b32000000bb6f00000000003200080000402b3200000000000000000032006f0000000000000000080800323232323200
-- 065:12121212120022222222220000000000000000000068002222220000000000000022222222000800080008005b6c400000001c00000000000000222222222200ef0022222222222212121212121212122200000000220000000022222222222222222222222222001c00222222000022222222222222000000000000000000222222222200222222222222220000000000006800002232323232323232000800005b000000000000000000000800000000000000000000320808080040003232320000000068000c0c0c00320828080800323200000000000000000032007828000000000000001c1c00323232323200
-- 066:2222222222002222222222000000000000004c00003c002222220000000000000022222222000000000000000012121212000000000000000000222222222200000022222222222222222222222222222200000000220000000022222222222222222222222222001c00222222000022222222222222000000000000000000222222222200222222222222220000000000003c004022323232323232320008000000000000006b00000000001c00000008080000000c0032080808000000000000000000003c00efefef0032083c080840003200000000000000000032003c3c00002c00000000000000323232323200
-- 067:22222222220022222222220000000000000000002222222222220000000000000022222222001200120012000022222222000000000000000000222222222200000022222222222222222222222222222200000000220000000022222222222222222222222222001c00222222000022222222222222000000000000000000222222222200222222222222220000001212121212122232323232323232323232323232323232323232323232323232323232323200ef00323232323232323232323232323232000000000032323232323232320000000000000000003232323232323232323200000000323232323200
-- 068:000000002f004f0000af007f006f000000cf0000cf4f00002f002f00af002f002f000000006f0000005f2f3f00cf0000005f00cfcf002f00cfcf2f000000006f000000002f2f00000000002f002f003f0000000000000000000000cfcf004f3f003f002f3f000000000000002f0000003f0000cfcf004f7f000000cf0000000000cf00002f0000cfcf0000004f003f2f0000000000000000003f00006fcf6f0000cfcfbf5f002f3f000000000000bf0000cfcf0000000000000000003f0000005f000000002f00cfcf002f002f002f00000000000000000000cfcf6f000000005f2f0000000000000000000000000000
-- 069:000000000000000000000000000033333300003300000000000000000033333333000000000000330000000000000000000000000000000000000000000000000000000000230000000000000000000000000000000000000000000000000000000000000023232323232323230000000000000000000023230000000000000000003333333333000000000000000000000000000023000000000000000000000000000033333333333333333333000000000033333333333333000000000000000000230000000000003333333333333333333333330000000000000000000000230000000000000000000000000000
-- 070:000000000000000000000000000033333300003300000000000000000033333333000000000000330000000000000000000000000000000000000000000000000000000000230000000000000000000000000000000000000000000000180000000000000000002323232323230000000000000000000023230000000000000000000000000000000000000000000000000000000023000000000000000000000000000033333333333333333333000000000033333333333333000000000000000000230000000000003333333333333333333333330000000000000000000000230000e50000000000000000000000
-- 071:0000000000000000000000000000333333000033000000000000008b00337c7c7c0000000000003300000000000000000000000000000000000000000000000000000000002300000000000000000000000000000000000000000808003c00000000000000000000232323232300000000000000002b002323000000000000000000008c002b000000000000000000000000000000230000000000000000000000000000333333333333333333330000000000337c337c337c330000000000000000002300000000001c1c0033333333333333007c000000000000000000000000230000000000000000000000000000
-- 072:0000000000000000000000000000333333000033000000000000000000330000000000000000003300000000000000000000000000000000000000001c0000000000000000230000950000007800e50000000000000000000000401c3333000000000000000000002323232323000000000000000033002323000000000000000000333333333300000000000000004343434343002300000000000000000000000000001c00007c0000000000000000000000330033003300330000000000000000002300000000001c1c00333333333300000000000000000000000000000000234013131300000000000000000000
-- 073:000000000000000000008c000000333333000033000000000000000000330000000000000000003300000000000000000000000000000000000000001ccb0000000000000023000000005b003c0000000000000000000000000008000000000000000000000000000000002323000000000000000000002323000000000000000000007c7c000000000000000000002323232323002300000000000000000000000000001c0000000000000000000000000000330033003300330000000000000000002300000000001c1ccb333333333300000000000000000000000000000000230000002300000000000000000000
-- 074:0000000000000000000033000000001c0000007c00000000008b000000330000000000000000000000000000000000000000000000002b8c0000000033330000000000000023401313131313131313130000000000000000000040000000000000000000000000000000002323000000000000000000001c1c000000000000000000000000000000000018000095000000000000002300000000000000000000000000001c0000000000000000000000000000001c1c1c1c1c000000008b008b0000002300000000001c1c33330000000000000000000000000000000000000000234000002300000000000000000000
-- 075:0000000000000000000000000000001c000000000000000000000000001c00000000000000000000000000000000000000000000000033330000000033330000000000000023002323232323232323230000000000000000000008000000000000000000000000000000000023000000000000000000001c1c6c000000008b00000000000000000000003c08080808080808080000230000000000000000002b8c0000001c0000000000008b002b0000000000001c1c1c1c1c00009500008b000000002300000000001c1c00000000000000000000000000000000001c1c0000002300002b2300000000000000000000
-- 076:0000000000000000000000000000001c000000000000000000000000001c00000000000000000000000000000000000000000000000000000000003333333300000000000023402323232323232323230000000000000000000040000000000000000000000000001b002b000000950000004800002b0013131313000000000000000000000000000013131313131313131313138b2300000000000000000033330000001ccb00000000000000330000000000001c1c1c1c1c000000003333330000002300000000001c1c000000000000008b8b00000000000000001c1c000000234033332300000000000000000000
-- 077:0000000000000000000000000000001c000000000000000000000000001c0000000000000000002b000000001b001b001b00000000000000000000333333330000000000002300232323232323232323000000000000000000000800000000000000000000000000131313130000000000003c0000330023000000008b0000000000000000000000002300000000000000e50023002300000000000000000000000000001c330000008b00008b330000000000131313131313131313131313134343002300000000001c1c33333333333333330000000000000000001c1ccb0000230000002300000000000000000000
-- 078:0000000000000000000000000000001c000000000000008b00000000001c0000000000000000333333003333333333333333330000000000000000333333330000000000000040232323232323232323000000000000000000004000000000000000000000006b6b2323232313131313001313000000002300000000000000008b00000000000000002300000000000000000023002300000000000000000000000000001c3300000000000000330000000000230000000000000000000000000000002300000000001c1c00333333333333330000000000000000003333333300234000002300000000000000000000
-- 079:0000000000000000000000001b003333330000000000000000000000001c0095000000000000003300001c7c7c00000000001c000000000000000033333333004343434343131323232323232323232300000000000000000000080000080000ef00950008131313232323232323232300232300000000230000000000000000000000000000000000234013131313131313132300239500ef0000480000000000000000333333333333333333330000000000230000000000000000000000000000002300000000001c1c00333300000000000000000000000000000000000000230000002300000000000000000000
-- 080:00000000000000000000000033003333330000000000000000000000001c0000006c00000000003300001c000000000000001c00000000000000003333333300232323232323232323232323232323230000000000000000000040000008000000000000082323232323232323232323002323000000002300000000000000000000000000000000002300000000000000000000002300000000003c0000000000000000333333333333333333330000000000230000000000009500000008080828002300000000001c1ccb3333000000000000000000000000000000000000002340002b2300000000000000000000
-- 081:00ef000000000000000000000000333333000000000000000000000000131313131300000000003300001c000000000000001c000000000000000033333333000023232323232323232323232323232300000000000000000000001c1c1c00131313131313232323232323232323232300232300002b0023000000000000000000000000000000000023400000000000000000000023131313001c1300000000000000003333333333333333333300000000002300cb00000000000000000808083c13230000000000001313131300000000000000000000000000009500000000230033332300000000000000000000
-- 082:00000095004f004800000000000033333300000000008b000000000000232323232300480000003300001c000000008c00001c000000000000000033333333000000232323232323232323232323232300000000000000000000000000000023232323232323232323232323232323230023230000330023004800000000000000000000000000000023000000000000000000280023232323000023000000000000000033333333333333333333000000000023001313131313131313131313131323230000480000002323232300000000000000000000000000000000000000004000002300000000000000000000
-- 083:00000000005c003c0000000000003333330000000000000000000000002323232323003c0000003300001c00000000338b8b1c000000000000000033333333000000002323232323232323232323232300000000000000000000000000000023232323232323232323232323232323230023230000000023003c0000000000000000000000000000002340cb000000005b00003c0023232323000023000000000000000033333333333333333333002b8c0000230000000000000000000000000000006c00003c00000023232323008c000000000000002b000000001313434343131313132300000000000000000000
-- 084:1313131313131313130000000000333333000000000000000000000000232323232313131300003300001c000000003300001c000000000000000033333333000000000023232323232323232323232300000000000000000000000000000023232323232323232323232323232323230023230000000023131313000000000000000000000000000023131313131313131313131323232323000023000000000000000033333333333333333333003333000023131313131313131313131313131313131313130000002323232300330000000000003333330000000000000000000000000000000000000000000000
-- 085:2f003f2f0000002f2f2f002f000000003f3f002f6f00002f002f00002f3f0000004f000000002f002f002f002f0000002f2f00002f000000006fcf000000cf00003f002f3f2f000000002f002f000000000000002f0000000000000000cf006f000000000000002f00af00002f00af00000000000000000000cf2f00002f0000004f0000002f0000000000005f00000000cfcf6f000000000000003f0000000000002f003f000000006f00000000008f0000000000002f0000007f003f5f0000000000002f2f0000000000003f002f0000007f2f2f00000000000000002f00002f000000000000000000000000000000
-- 086:000000000000000000000000000000000000000000000000000000303030303030300000000000000000000000000000000000000000000000050000000000000000280000000000000000000000000000000000000000000000000000000800000000000000000000002c2c2c0000000000000000000000000000000000000000000000000000313131313131313131313131010131000000000030000000000000000030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000030000000000030000000000000000000003030003030000000
-- 087:000000000000000000000000000000880000000000000000000000303030303030300000000008000000000000000000000000000000000000200000000000002b003c000000004b000000000000000000000010000000100000003140310101010101010101010101013131310101010101010101010101010101010101010101010101010131000000000000000000003131000031000000000003000000000000000003000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000180030000000000003000000000000000000003030000303000000
-- 088:0000000000000000000000000000003c0000000000000000000000303030303030300000005b000000000000000000000000000000000000002000000000003030303030033030300000000000000000000000200101012000000031583100000000000000000000000031313100000808080808080800db1800000000000000000000000000310000000808000000000031310888310000000000030000000000000000030000000000000000000000300000000000003000000000300000000000000030000000000000000000000000000000003c08300000000000031b00006b0000000000003030000303000000
-- 089:0000000000000000000000000040303000000000000000000000000000000000003000000030303000001c00001c1c000010401010000000182000000000000000000000030000000000000000000000004000200000002000000031403100000000000000000000000031313100000000000000db0000003c00000000000000000000db000031000808080800000000003131083c31000000000003000000000000000003000008000000000000000030000000000000300000000003000000000000000300000000000000000000000000000000304030000000000003303030304040404040003030000303000000
-- 090:00000000000000000000000000000000000000000000000000000000000000000030004000303030000000000000000000200020200000003c2000000000000000000000030000000000000000000000000000200000002000000031683100000808080000db00000000313131000031313131313131313131000000db00000000000000000031000808004c3100000000313100313100000000000300000000000000000300000008000000000000003000006f000000300000000003000000000000000300000000000000000000000000000000000830000000000003000000000000000000003030000303000000
-- 091:0000000808080000000000000040000000000000000000000000000000000000003000000030303000000000000000000020402020001010102000000000000000000000030000000000000000000000004000200000eb200000003140310000080808000000000000007c7c7c000031000000000000000031000000000000000000000000003100004c000031000008003131000131000000000003000000000000080003000000000000000000000030000078000000150000000003000000000000000300000000000000000000000000000000004030000000000003002b00000040404040403030000303000000
-- 092:00ef000028000000000000000000000000000000000000000000003008080808083000400030303000000000000000000020002020000000002000000000000000000000030000000000000000000000000000200000002000000031783100000000000000000000000000000000003100000008000800003100000008000000db00000000003100002c2c2c312c2c0800313108883100ef0000000300004b00000000000300000000000000000000003000003c000000150000000003000000000000000300000000000000000000000000002c000008300000000000033030002c0000000000003030000303000000
-- 093:000000003c000000000000000040007b00000000000b0000004c003001010101013001300130303000000000000000000020402020004b0000200000000000000000000003002b00000000000000000000400020000000200000003140310000000000000000000000000000000000310000000800080000310000000800000008000000000031400031313131313100003131083c31303030303003303030303000000003000000000000000000000030303030303030300000000003000000000000000300000000000000000000002b00003000004030000000000003000000304040404040003030000303e50000
-- 094:10101010101010010101011010101010010101011010004c00000030000000db00300001003030300000000000000000002000202010101000200000000000000000000003303030000000000000000000000020000000200000003188310000000000000000000000000202020000310000001c001c00403100000008000000080000cb00003100007c000031000000003131003131003030300003003030300000000003000000000000000000000030303030303030303000000003000000000000000300003000000030003000303030007c00000830000000000003000000000000000000003030000303000000
-- 095:20202020202020000000002020202020000000002020000000000030000000000001000000303030000000000000000000204000200000000020000000000000000000000300000000000000000000000040002000000020000000314031000000000000080808000000000000000031882b000000000000310000000000000000003131310031400000000031000000003131000131000030000003000030000000000003000000000000303030300130303030303030303030013003000000000000000300000000000000000000003000000000004030000000000003002b00000040404040403030000303303000
-- 096:2020202020202000080000202020202000080800202000000000003000000000000800000030303000000000000000000020000020000000002000000000000000000000030000000000000000000000001c00200000eb2000000031003100000000000008080800db000000000000313131310000000040310000000000db0000007c7c7c0031000000000031000800003131088831000030000003000030000000000003000000000040300101300030303030303030303001003003000000000000000300000000000000000000003001010101013001010101010101303000000000000000003030000303303000
-- 097:20202020202020000800000101010101000808002020000000000030000000000000db00003030300000000000000000002040002000101010200000000000000000000003000000000000000000001c0000002003202020000000314031000000000000000000000000000000000031010101010101013131000000000000000000020202003140000000003100082c2c3131083c3100003000000300003000000000000328000000000030000030007c7c00000000007c7c00003003000000000000000300000000000000000000003000000000000100000000000000303001010101010101013030010101303000
-- 098:202020202020200000007800000000000000db0020200000000000300800280000303000003030300101010101010101012001202001010101010101010101101010100101011000001c001c001c0000000000200300002000000000003100000000000000000000000000000000003100000000000000013100000000000800880000000000010101013131310000313131313131310000300000030000300000000000033c000000004030000030000202020202020202020000300300000000280000030000000000000000000000300000000000eb00000000000000303000000000000000000101db0000303000
-- 099:202020202020200000003c000808080000000000202000000000003008003c00003030000030303000880088000000eb00200020200000000000000078eb00202020200000db200000000000000000000000002003e50020000000284031000000000000000000000000002800000001000000000000000001000000000008003c000000eb00000000000101310000e5003131313131000030000003000030000000000003300000000000307800150000000000000000db0000003003008b6c003c00000300000000180000000000003000000000000000000000002800303000000000000000000000000000303000
-- 100:20202020202020202020202020000000000000002020000000000030303030303030303030303030003c003c0000db0000010020200000eb6c0000db3c0000202020200000002000000000000000000000000020030000200000003c0031000000ef0000000000000000003c00eb00000000000000000000000000db0000080031000878080000000000000031000000003131313131000030000003000030000000000003000000000040303c0015000000000000eb000000000030030000303030300003000000003c0000000000003000000000000000000000cb3c00303000000000002c2c2c2c2c2c2c2c303000
-- 101:202020202020202020202020202020202020202020200000000000303030303030303030303030300030003000000000000000202010101010100030303000202020202020202000000000000000000000000020202020200000003131313131313131313131313131313131313131000000000000000000000000000000000031000000000000000000000031313131313131313131000030000003000030000000000003000000000000303030303030303030303030303030303003000000303000000300301c1c1c000000000000300000000000000000db00303000303030303030303030303030303030303000
-- 102:000000000000005f3f2f3f00000000000000000000002f00cf9f0000004f003f004f00cfcf2f002f0000cfcf009f005f00002f4f002f00000000002f00000000004f4f2f0000002f0000004f00004f003f003f003f003f0000002f000000002f002f000000002f000000005f000000002f5f0000002f00003f00002f2f2f2f000000000000000000000000003f008f003f0000000000002f0000003f00000000000000005f0000000000000000003f003f003f000000000000cfbf004f003fcf8f5f0000000000000000000000000000cf0000000000000000000000002f000000000000000000000000000000000000
-- 103:00800000000000000000000000000000000000000080000000001c1c1c0000000000000000000000008000000000008000000000000000000000000000000000000000800000000000000000000000800080000000000000000000000000000000000000000000000000000080000000000080808000000000000000000000000000000000ffffff000000000000000000000000008000000000000000000000808080808080808080808080808080808080800000000000000000001c1c1c00000080000000000000008080808080800000000000000000000000000000000000000000000000000000000000000000
-- 104:0080000000002b000000000000000000000000000080000000001c1c1c00000000000000000000000080000000004080000080808080808080808080808000000000008000000000000000000000008000800000000000000000000000000000ef00000000000000000000000300000000007c7c7c000000000000000000000000002b0000000000000000000000000000000000000300000000000000000000807c00000000000000000000000000800300030000000000000000001c1c1c00000080000000000080000000000000800000000000000000000000000000000000000000000000000000000000000000
-- 105:00800080808080808080808000800080008000000080000000001c1c1c0000000000000000000000008000000000008028000000000000000000000000800000000000800000000000000000000000800080000000000000000000800000000080000000008000000000000003000000ef000000000000000000000000000000008080800000000000000080001c0000000000000003000000000000007b0000800000000000000000000000000000800300030000000000000000001ccb1c00000080808080800080000000000000800000000000000000000000005500e7f700000000000000000000000000000000
-- 106:00800080000000000000000000000000000000400080000000001c1c1c000000000000000000001ccb800000180040803c000000000000007b000000008000000000008028000000000000000000008000800000000000000000008001010101800101010180000000000000035b00000000000000000000000000000000000000000000000000005b00000000000000006f0000000340404080404040404000800000000000000000000000000000800300034040800000000000001c331c000000800000005b4080000000000000800000000000000000000000000000e8f800000000000000000000000000000000
-- 107:00800080000000000000000000000000000000000080000000001c1c1c000000000000000000001c808000003c00008080808080808080808080808000800000000000803c0000002b007b00000000800080000000000000000000805800000001000000688000000000000003005b0000000000000000000000000000000000000000000000000000000000000000000088000000030000008000404040404000002800000000000000000000000080035b035b00800000000000001c1c1c0000008000005b000080180000000000800000000000000000000000001111111100000000000000000000000000000000
-- 108:00800080000000000000000000000000000000400080000000001c1c1c0000000000000000000000000000008000408000000000000000000000000040800000000000808080808080808080408000800080000000000000000000803c2b00000000002b3c80000000000000030000000000808080000000000000000000000000000000000000000000000000000000003c002b00030000008000000000000b00003c7b000000000000000000cb00800300030000800000000000001c1c1c000000800000005b40003c80002b0000800000000000000000000000212121212100000000000000000000000000000000
-- 109:00800080000000000000000000000000000000000080000000001ccb1c00000000000000000000000000000000000080000000000000000000000000008000000000000000007c0000007c000080008000800000000000000000008080808000000080808080000000000000030000000c0080708000000000000000000000000000000000000000000000000000000000808080800300000080808080808080808080808080808080808080808001800300030000800000000000001c1c1c00000080008080808080808080808000800000000000000000000010202020202000000000000000000000000000000000
-- 110:008000800000000000000000000000000000004008800000000080808000000000000000000808080808000000004080000000000000009b00000000408000000000000000000000000000004080008000800000000000000000008001010100000001010180000000000000030000000000807080000000080000000000000000000000000000000000000000000000000000000003000000000000800101010101010101010101010101010101008003000300008000000000008c1ccb1c00000080400000000080000000000000800000000000000000001020202020202000000000000000000000000000000000
-- 111:00800080ef0000000000000000000000001b00003c800000000080808000000000000000000808080808000000000080000000000000808080000000008000000000000000000000000000000080007c007c00000000000000000080000000000000002b0080000000000000030000000000807080000000006b000000000000000000000000000000000000000000000000000000030000000000008000000000000000000000db00000000000000800300030000800000000000001c331c00000080400000000080880000000000800000000000000000102020202020202000000000000000000000000000000000
-- 112:00800080000000000000006000008b00606060606060000000008080800000000000000000000000000000000000408000000000000000000000000040800000000000000000000000000000408000000000000000000000000000808080800000008080808000000000000003005b00ff0080708000808080808000000000008b1c1c00000c0c0c00000000000000000000000000035b000000000080000000000000db000000000000000000eb0080035b035b00800000000000001c1c1c000000804b4b4b0000803c9b00000000800000000000000010202020202020202000000000000000000000000000000000
-- 113:008000800000000000600070000000007070707070700000000080808000000000002b00000000000000000000000080000000000000000000000000008000000000000000000000000000000080000000000000000000000000008001010100000001010180000000000000035b000000008070800080707070800000001c000000000000efefef004000000000000000000000000300000000000080000000000000000000000000db0000000000800380030000800000000000001c1c1c00000080808080404080808080000000800000000000006070707070707070707000000000000000000000000000000000
-- 114:008000806060606000700070000000007070707070700000000080808000000000008000001ccb000000000000004080000000000000000000000000408000000000000000000000000000004080000000000000000000e500000080002b0000000000000080000000001b00030000000000807080008070707080001c00000000000000000000000000000000000000000000000003000000000000800000db0000000000eb004f00000000000000800380030000800000000000001c1c1c000000800000000028800000004000008000006f0000607070707070707070707000000000000000000000000000000000
-- 115:008000807070707000700070000000007070707070700000000080808000000000008000001c80000000000000000080000000006b000000000000006080006c000000000000000000000000008000000000000000000000000000808080800303038080808000001b008000030000000000807080008070707080000000000000000000000000000040000000000000000000000003000018000000800000000000000000000078000000db000000800380030000800000000000001ccb1c00000000006c00003c8000002b000000800000880060707070707070707070707000000000000000000000000000000000
-- 116:00800080707070702c702c702c2c2c2c70707070707000480000808080008c002b008000000080000000000000004000002b00606000001c00001c0070806060606060000000600000006000408000800080001c001c001c1c0000000000000303030000000000008000800003000000000080708000807070708000000000000000000000000000000000000000000000000000000300003c00000080000000000000eb0000003c0000000000eb00800380030000800000480000001c331c000043808080808080800080808080808000003c6070707070707070707070707000000000000000000000000000000000
-- 117:00800000000000000000000000000000000000000000003c000080808000800080008000000080000000000000436060606000707000000000000000708070707070700000007000000070000080008000800000000000000000000000000003030300000000000080008000030000000000807080008070707080000000000000000000002c6c002c4000000000001c001c000000030000801c000080008080808080808080808080808080808080800380036c008000003c0000001c1c1c00007001010101010101010101010101010160607070707070707070707070707000000000000000000000000000000000
-- 118:00808080808080808080808080808080808080808080808000008080800080008000800000008000000000000070707070700070700000000000000070807070707070000000700000007000008000800080000000000000000000606060606060606060606060008000800003000000000080708000807070708000000000000000000000808080800000000000000000000000000300000000000080000101010101010101010101010101010101010180038080800080800000001c1c1c00007000000000000000000000000000000070707070707070707070707070707000000000000000000000000000000000
-- 121:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001f00001f00000000000000000000000000000000000000000000002020202020200000000000000021212121212121000000002222222222000000000000000000000000000000000000000000000000000000000000
-- 122:00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000d3f0f0e30000000000000000e3e0e0f3e0e0d0d0e0e0d3000000002020202020202000000000002121212121212121210000222222222222000000000000000000000000000000000000000000000000000000000000
-- 123:00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000f10000f10000000000000000e12f2f0000000000ff3fe1000000202020202020202000000000002121212121212121210022222222222200000000000000000000000000000000000000000000000025354500000000
-- 124:0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000f2f0f2001ff10000000000000000e1000000000000000000e1000000002020202020202020000000212121212121212121210000222222222200000000000000000000000000000000000000000000000000000000000000
-- 125:0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ef00000000f3f0d0d0d0e0e0d3e0e200000000000000003fe3e0e200002020202020202020000000212121212121212100000000222222222222000000002535450000280000000000007800080808000000000000000000
-- 126:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ff2f0000000000000000000000000000e1000000202020202000200000000021212121000000000000002222222222220000000000000000003c0000000000000000080808000000000000000000
-- 127:00000000000000d700000000000000000000000000c7000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000e10000000000d4e4c0000000000000d4e4c10000000000000000222222222222000000000000000030303000000000003030303030000000000000000000
-- 128:00000000000000d500d600000000000000000000b8c8d80000000000000000000000004b00000000002b00000000007b00000000009b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000003fe100000000000000000000000000000000000000002323232300002222222222002535450000000000000000000000000000000000000000000000000000
-- 129:000000000000000000d7000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000d3e0d0d0e0e0f300000000000000000000000000000000000000232323232323000022222222000000000000000000000000000000000000000000000000000000000000
-- 130:00000000000000000000000000000000000000000000000000000000000000000000000000001b00000000005b00000000008b00000000cb0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000e2e0e3e0e200000000000000e14fff00000000000000707070d4e4c500000000000000000023232323232323230022222200000000000000000000000000000000000000000000000000000000000000
-- 131:00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000e15f0000e1000000004f0000e1000000000000000000707070707000000000000000000000232323232323232300002200000000000055650000000000000000000000000000000000000000e5f50000
-- 132:0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000e3e0e0d3e0e0d0d0f3000000d3d0d0d0e0f3e0e0e34f000000000000007070707070707000000000000000000000232323232323232300d4e4c2000000265666264b000b001b062b005b007b008b009b00cb2636e6f60000
-- 133:000000000000000000000000000000000000000000000000000000000000000000000000000000000000db0000000000eb000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006f0000006fff000000000000005fff000000000000000000000000000070707070707000000000d4e4c400000000002323232323000000000000101010101010101010101010101010101010101010101010101010101010
-- 134:00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006f000000000000000000000000000000000000000000000000000000000000000000000000000000d4e4c3232323000000000000202020202020202020202020202020202020202020202020202020202020
-- 135:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000b8c7c8d800000000000000d5000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- </MAP>

-- <WAVES>
-- 000:00000000ffffffff00000000ffffffff
-- 001:0123456789abcdefedcba98765432100
-- 002:00123456789abcdedcba456789aba987
-- 003:2456789abcddeeedcb98654321100000
-- 004:6655443332222222233334455667889a
-- 005:1577dc5df4bebc9f4a27d7de3c54ca3e
-- </WAVES>

-- <SFX>
-- 000:d100c100b100a1008100710071006100610061006100610071008100810081009100a100a100a100a100b100b100c100d100d100e100e100e100f100507000000000
-- 001:f130e100c130a10091308100713071007130710081309100a130a100b130c100d130e100f130f100f130f100f130f100f130f100f130f100f130f100410000000000
-- 002:d100c100c100b100b100a100a100a100a100a100b100b100b100c100c100c100d100d100d100d100e100e100e100f100f100f100f100f100f100f100412000000000
-- 003:b400a400940084008400740074006400640054005400540054006400640074008400840094009400a400a400b400b400b400c400c400d400d400d400305000000000
-- 004:9560a560b570d570d570e570e570e570f570f570f570f560f560f560f560f560f570f570f580f580f570f560f560f560f560f560f560f560f560f560009000000000
-- 005:210021002100210021002100210021002100210021002100310031003100310031003100310031003100310031003100310031003100310031003100202000000000
-- 006:8100810081008100810081008100810081009100910091009100a100a100b100b100b100c100c100c100d100d100d100e100e100e100f100f100f100205000000000
-- 007:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000304000000000
-- 008:030003000300030003000300030003000300030003000300030003000300030003000300030003000300030003000300030003000300030003000300407000000000
-- 010:51004100310031002100210021002100210031003100410041005100510061007100810081009100a100b100b100c100d100e100f100f100f100f100202000000000
-- 011:01000100010001000100010001000100f100f100f100f100f100f100f100f100f100f100f100f100f100f100f100f100f100f100f100f100f100f100404000000000
-- 058:000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002000000000
-- 059:b600f600d600f600c600f600c600f600b600f6009600f600a600f600c610f610a620f6309630f640a640f650b660f660d670f670e670f680e680f680350000000000
-- 060:60008010a020a030b040c040c050d060e070e070f080f090f0a0f0b0f0c0f0c0f0d0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0350000000000
-- 061:a0009010802080308040904090509060a060a070b080c080c090d090d0a0d0a0f0a0f0b0f0b0f0b0f0b0f0b0f0b0f0b0f0c0f0c0f0c0f0c0f0c0f0c0202000000000
-- 062:7660a640e620e600f600f600f600f600f600f600f600f600f600f600f600f600f600f600f600f600f600f600f600f600f600f600f600f600f600f600270000000000
-- 063:569686969695a695b694c693c691d690d68ee68de67de66cf65bf64bf63bf62af61af609f608f608f608f608f608f608f608f608f608f608f608f608300000000000
-- </SFX>

-- <PATTERNS>
-- 000:4aa1648aa164baa164000000baa1660000008aa1660000004aa1648aa164baa164000000baa1660000008aa1660000004aa1648aa164baa164000000baa1660000008aa1660000004aa1648aa164baa164000000baa1660000008aa1660000004aa1648aa164baa164000000baa1660000008aa1660000004aa1648aa164baa164000000baa1660000008aa1660000004aa1648aa164baa164000000baa1660000008aa1660000004aa1648aa164baa164000000baa1660000008aa166000000
-- 001:4ff1404881404881400000004ff1420000004881404881404ff1400000004881420000004ff1404881404881400000004ff1420000004881404881404ff1400000004881420000004ff1404881404881400000004ff1420000004881404881404ff1400000004881420000004ff1404881404881400000004ff1420000004881404881404ff1400000004881420000004ff1404881404881400000004ff1420000004881404881404ff1400000004881420000004ff140488140488140000000
-- 002:bff108000000bff108000000dff108000000bff1080000009ff1080000008ff1089ff108bff108000000000000000000bff108000000bff108000000dff108000000bff1080000009ff1080000009ff1088ff1086ff1080000000000000000009ff1080000009ff108000000bff1080000009ff1080000008ff1080000004ff1086ff1088ff1080000000000000000008ff1080000008ff1080000009ff1080000008ff1080000006ff1080000008ff1086ff1084ff108000000000000000000
-- 003:bff10a000000bff10a000000dff10a000000bff10a0000009ff10a0000008ff10a9ff10abff10a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000009ff10a0000009ff10a000000bff10a0000009ff10a0000008ff10a0000004ff10a6ff10a8ff10a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 004:bff108000000bff108000000dff108000000bff1080000009ff1080000009ff1088ff1086ff108000000000000000000dff108000000bff1080000000000000000000000000000009ff1080000008ff108000000000000000000000000000000fff108000000dff108000000000000000000000000000000bff1080000009ff1080000000000000000000000000000008ff1080000006ff1080000000000000000000000000000006ff1080000004ff1080000006ff1680000008ff168000000
-- 005:bff108000000dff108000000bff1080000009ff1080000008ff1080000006ff1080000008ff1080000009ff108000000bff108000000dff108000000fff108000000dff108000000bff1080000009ff1080000008ff1080000004ff1080000006ff1080000008ff1080000009ff1080000008ff1080000006ff1080000004ff108000000000000000000000000000000bff108000000bff108000000dff108000000bff1080000009ff1080000008ff1089ff108bff108000000000000000000
-- 009:4ff164000000bff1640000004ff164000000bff1640000004ff164000000bff1640000004ff164000000bff1640000004ff164000000bff1640000004ff164000000bff1640000004ff164000000bff1640000004ff164000000bff1640000004ff164000000bff1640000004ff164000000bff1640000004ff164000000bff1640000004ff164000000bff1640000004ff164000000bff1640000004ff164000000bff1640000004ff164000000bff1640000004ff164000000bff164000000
-- 010:4ff1424ff1400000000000004ff1420000000000000000004ff1424ff1400000000000004ff1420000000000000000004ff1424ff1400000000000004ff1420000000000000000004ff1424ff1400000000000004ff1420000000000000000004ff1424ff1400000000000004ff1420000000000000000004ff1424ff1400000000000004ff1420000000000000000004ff1424ff1400000000000004ff1420000000000000000004ff1424ff1400000000000004ff142000000000000000000
-- 011:8ff1081000606ff1088ff1081000008ff1080000000000000000000000000000000000000000000000000000000000008ff1081000006ff1088ff1081000008ff108000000000000000000000000000000000000000000000000000000000000bff1081000009ff108bff108000000bff108000000000000000000000000000000000000000000000000000000000000bff1081000009ff108bff108000000bff108000000000000000000000000000000000000000000000000000000000000
-- 012:9ff1081000008ff1089ff1081000008ff108bff108100000bff1089ff1081000009ff1088ff108100000dff108bff108100000fff108dff108100000dff108bff108100000bff1089ff108000000000000000000000000000000000000000000bff1081000009ff108bff108100000dff108bff108100000fff108dff1081000006ff10a4ff10a1000009ff10a8ff10a1000009ff10adff10a000000000000000000000000000000bff10a1000009ff10abff10a100000bff10a000000000000
-- 013:8ff108000000dff108000000bff1080000009ff1080000008ff1080000006ff108000000000000000000000000000000bff10a1000009ff10abff10a100000bff10a0000000000008ff108000000bff1080000009ff1080000008ff1080000006ff1080000004ff108000000000000000000000000000000fff108100000dff108fff108100000fff1080000000000000000000000000000000000009ff108000000bff1080000009ff1080000008ff1080000006ff1080000004ff108000000
-- 014:8ff16a0000009ff16a0000009ff16a0000009ff16a0000008ff16a0000009ff16a0000009ff16a0000009ff16a0000008ff16a000000bff16a0000009ff16a0000008ff16a0000006ff16a0000008ff16a0000008ff16a0000008ff16a0000006ff16a0000008ff16a0000008ff16a0000008ff16a0000006ff16a0000009ff16a0000008ff16a0000006ff16a0000004ff16a0000006ff16a0000006ff16a0000006ff16a0000004ff16a0000006ff16a0000006ff16a0000006ff16a000000
-- 015:4ff16a0000008ff16a0000006ff16a0000004ff16a000000fff1680000004ff16a0000000000000000000000000000000000000000000000000000004ff1680000004ff1680000006ff1680000008ff1680000000000000000000000000000004ff16a0000004ff16a0000006ff16a0000008ff16a0000000000000000000000000000006ff1680000006ff1680000008ff1680000009ff1680000000000000000000000000000006ff16a0000006ff16a0000008ff16a0000009ff16a000000
-- 019:4aa1a60000004aa1a40000004aa1a60000004aa1a40000004aa1a60000004aa1a40000004aa1a60000004aa1a40000006aa1a60000006aa1a40000006aa1a60000006aa1a40000006aa1a60000006aa1a40000006aa1a60000006aa1a4000000baa1a6000000baa1a4000000baa1a6000000baa1a4000000baa1a6000000baa1a4000000baa1a6000000baa1a40000008aa1a60000008aa1a40000008aa1a60000008aa1a40000008aa1a60000008aa1a40000006aa1a60000006aa1a4000000
-- 020:4aa1400000004aa1404aa1420000004aa1404aa1420000004aa1400000004aa1404aa1420000004aa1404aa1420000004aa1400000004aa1404aa1420000004aa1404aa1420000004aa1400000004aa1404aa1420000004aa1404aa1420000004aa1400000004aa1404aa1420000004aa1404aa1420000004aa1400000004aa1404aa1420000004aa1404aa1420000004aa1400000004aa1404aa1420000004aa1404aa1420000004aa1400000004aa1404aa1420000004aa1404aa142000000
-- 021:bff108000000bff1080000009ff1080000008ff1089ff108bff1080000006ff108000000000000000000000000000000bff108000000bff1080000009ff1080000008ff1089ff108bff108000000bff108000000000000000000000000000000bff108000000bff1080000009ff1080000008ff1089ff108bff1080000006ff108000000000000000000000000000000bff1080000009ff1080000006ff1080000008ff1086ff1084ff1080000004ff108000000000000000000000000000000
-- 022:4ff1b80000004ff1b80000006ff1b80000008ff1b8000000bff1b8000000bff1b8000000dff1b8000000bff1b80000000000000000000000000000000000000000000000000000004ff1ba0000004ff1ba0000008ff1ba000000bff1ba000000dff1ba000000dff1ba000000fff1ba000000dff1ba0000000000000000000000000000000000000000000000000000008ff1ba0000008ff1ba0000006ff1ba0000008ff1ba0000009ff1ba0000009ff1ba0000006ff1ba0000004ff1ba000000
-- 023:4ff10a1000004ff10a1000006ff10a1000008ff10a1000000000000000000000000000000000000000000000000000006ff10a1000006ff10a100000aff10a100000bff10a100000000000000000000000000000000000000000000000000000bff10a100000bff10a100000dff10a100000fff10a100000000000000000000000000000000000000000000000000000fff10a000000bff10a000000dff10a0000009ff10a000000bff10a6ff10a8ff10a9ff10a000000000000000000000000
-- 024:bff1ba000000bff1ba0000009ff1ba0000009ff1ba0000008ff1ba0000008ff1ba0000006ff1ba0000006ff1ba000000dff1ba000000dff1ba000000bff1ba000000bff1ba0000009ff1ba0000009ff1ba0000008ff1ba0000008ff1ba000000bff1ba000000bff1ba0000009ff1ba0000009ff1ba0000008ff1ba0000008ff1ba0000006ff1ba0000006ff1ba000000dff1ba000000dff1ba000000bff1ba000000bff1ba0000009ff1ba0000009ff1ba0000008ff1ba0000008ff1ba000000
-- 025:dff1ba000000dff1ba000000bff1ba0000009ff1ba000000000000000000000000000000000000000000000000000000bff1ba000000bff1ba0000009ff1ba0000008ff1ba0000000000000000000000000000000000000000000000000000009ff1ba0000009ff1ba0000008ff1ba0000006ff1ba0000004ff1ba0000004ff1ba0000006ff1ba0000008ff1ba0000009ff1ba0000009ff1ba0000006ff1ba0000004ff1ba000000000000000000000000000000000000000000000000000000
-- 026:bff10a1000000000000000009ff10a1000000000009ff10abff10a100000000000000000000000000000000000000000bff10a1000000000000000009ff10a1000000000009ff10abff10a100000000000000000000000000000000000000000bff10a1000000000000000009ff10a1000000000009ff10abff10a100000000000000000000000000000000000000000bff10a1000009ff10a0000006ff10a0000008ff10a6ff10a4ff10a0000004ff10a4ff10a6ff10a8ff10a9ff10abff10a
-- 027:4ff1081000004ff1081000006ff1081000008ff108100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000bff108100000bff108100000dff108100000fff108100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 029:4ff1686ff1688ff1689ff168bff168000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 030:0000000000004ff1686ff1688ff1689ff168bff168000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 031:0000000000000000000000004ff16a6ff16a8ff16a9ff16abff16a9ff16abff16a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
-- 039:4ff1664ff1640000000000004ff1660000000000000000006ff1666ff1640000000000006ff1660000000000000000004ff1664ff1640000000000004ff1660000000000000000008ff1668ff1640000000000008ff166000000000000000000bff166bff164000000000000bff1660000000000000000006ff1666ff1640000000000006ff1660000000000000000004ff1664ff1640000000000004ff1660000000000000000006ff1666ff1640000000000006ff166000000000000000000
-- 040:4ff1404ff1400000004ff1404ff1400000000000000000006ff1406ff1400000006ff1406ff1400000000000000000004ff1404ff1400000004ff1404ff1400000000000000000008ff1408ff1400000008ff1408ff140000000000000000000bff140bff140000000bff140bff1400000000000000000006ff1406ff1400000006ff1406ff1400000000000000000004ff1404ff1400000004ff1404ff1400000000000000000006ff1406ff1400000006ff1406ff140000000000000000000
-- 041:bff168100060bff168100000dff168bff168dff1680000006ff1681000006ff1681000608ff1686ff1688ff1680000004ff1681000604ff1681000006ff1684ff1686ff1680000008ff1681000009ff168100000bff168100000dff168100000bff1681000009ff1681000008ff168100000fff1664ff1686ff1681000606ff168100000dff168100060bff1681000609ff1681000008ff1681000006ff1688ff1689ff168100060bff1689ff1688ff1681000009ff1688ff1686ff1684ff168
-- 042:4ff1668ff166bff1668ff1664ff1668ff166bff1660000006ff1669ff166dff1669ff1666ff1660000000000000000004ff1668ff166bff1668ff1664ff1660000000000000000008ff166bff166fff166bff1668ff166000000000000000000bff166fff1666ff168fff166bff1660000000000000000006ff1669ff166dff1669ff1666ff1660000000000000000004ff1668ff166bff1668ff1664ff1660000000000000000006ff1669ff166dff1669ff1666ff166000000000000000000
-- 049:4ff1668ff166bff1668ff1664ff1668ff166bff1668ff1664ff1668ff166bff1668ff1664ff1668ff166bff1668ff1664ff1668ff166bff1668ff1664ff1668ff166bff1668ff1664ff1668ff166bff1668ff1664ff1668ff166bff1668ff1664ff1668ff166bff1668ff1664ff1668ff166bff1668ff1664ff1668ff166bff1668ff1664ff1668ff166bff1668ff1664ff1668ff166bff1668ff1664ff1668ff166bff1668ff1664ff1668ff166bff1668ff1664ff1668ff166bff1668ff166
-- 050:4ff1424881404881404881404ff1424881404881404881404ff1424881404881404881404ff1424881404881404881404ff1424881404881404881404ff1424881404881404881404ff1424881404881404881404ff1424881404881404881404ff1424881404881404881404ff1424881404881404881404ff1424881404881404881404ff1424881404881404881404ff1424881404881404881404ff1424881404881404881404ff1424881404881404881404ff142488140488140488140
-- 051:fff168bff168dff1689ff168bff1688ff1689ff1686ff1688ff1684ff1686ff1688ff1689ff168bff168dff168dff168dff168fff168dff168bff1689ff168bff168bff168bff168dff168bff1689ff1688ff1689ff1689ff1689ff1688ff1688ff1689ff168bff168dff168fff168dff168bff1689ff168fff168fff168dff1689ff168bff1688ff1689ff1686ff1688ff1684ff168bff168bff1689ff168bff168dff168fff168dff168bff1689ff1688ff1688ff168bff168dff168fff168
-- 052:dff168100000bff1681000009ff168100000dff168100000bff1681000009ff168100000fff168100000dff168100060bff1681000008ff16a1000006ff16a1000004ff16a1000009ff16a1000008ff16a1000006ff16a100000bff16a1000009ff16a1000608ff16a100000dff16a100000bff16a1000009ff16a1000004ff16a6ff16a8ff16a9ff16abff16a9ff16a8ff16a6ff16a4ff16a1000008ff16a9ff16abff16adff16afff16adff16abff16a9ff16a8ff16a0000004ff1686ff168
-- 054:bff1861000801000001000009ff1861000008ff1869ff186bff1861000006ff186100000000000000000000000000000bff1861000000000000000009ff1861000008ff1869ff186bff186100000000000000000000000000000000000000000bff1881000000000000000009ff188100000000000000000bff1881000006ff188100000000000000000000000000000bff1880000009ff1880000006ff1880000008ff1886ff1884ff1880000004ff188100000000000000000000000000000
-- 055:bff10a000000bff10a0000009ff10a0000008ff10a9ff10abff10a0000006ff10a0000004ff10a6ff10a8ff10a9ff10abff10a000000bff10a0000009ff10a0000008ff10a9ff10abff10a000000bff10a0000004ff10a6ff10a8ff10a9ff10abff10a000000bff10a0000009ff10a0000008ff10a9ff10abff10a0000006ff10a0000006ff10c4ff10cfff10adff10abff10a0000009ff10a0000006ff10a0000008ff10a6ff10a4ff10a0000004ff10a000000000000000000000000000000
-- 056:9ff1081000008ff1081000006ff1081000008ff1081000009ff1081000008ff1081000006ff1081000008ff1081000006ff1081000004ff108100000bff1081000009ff1081000008ff1081000009ff1081000008ff1081000006ff1081000004ff108100000dff108100000bff1081000009ff1081000008ff1081000006ff1081000004ff1080000000000000000000000000000000000000000008ff1086ff1081000000000000000000000000000000000006ff1084ff108100000000000
-- 057:9ff1089ff1081000000000000000000000000000000000009ff1089ff1081000000000000000000000000000000000009ff1088ff1081000000000000000000000000000000000009ff1088ff1081000000000000000000000000000000000006ff1088ff1081000000000000000000000000000000000006ff1088ff1081000000000000000000000000000000000008ff1081000006ff1081000004ff1081000000000000000000000000000000000000000009ff1081000008ff108100000
-- 058:4ff1400000000000000000004ff1400000000000000000004ff1400000000000000000004ff1400000000000000000004ff1400000000000000000004ff1400000000000000000004ff1400000000000000000004ff140000000000000bff1404ff140000000000000bff1404ff140000000000000bff1404ff1400000000000000000004ff1400000000000000000004ff140000000000000bff1404ff140000000000000bff1404ff1400000000000000000004ff140000000000000000000
-- 059:4ff1068ff1060000000000000000000000000000000000004ff1068ff1060000000000000000000000000000000000004ff1068ff1060000000000000000000000000000000000006ff1068ff106000000000000000000000000000000000000bff106dff106000000000000000000000000000000bff106dff1060000000000000000004ff1066ff1060000000000000000000000000000004ff1066ff1060000000000000000000000000000000000000000004ff1066ff106000000000000
-- </PATTERNS>

-- <TRACKS>
-- 000:1803001803011805001806000000000000000000000000000000000000000000000000000000000000000000000000004c0000
-- 001:ac2c00ac2d00ac2e00ac2e00ac2d000000000000000000000000000000000000000000000000000000000000000000000b00ff
-- 002:ed7068000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ec0000
-- 003:4556104556d6455c16455c16455957455a10455a10000000000000000000000000000000000000000000000000000000ec0000
-- 004:86aa2086aaea000000000000000000000000000000000000000000000000000000000000000000000000000000000000ab0000
-- 005:2fc4302fc530000000000000000000000000000000000000000000000000000000000000000000000000000000000000ec0000
-- 006:cfea30cfe9300000000000000000000000000000000000000000000000000000000000000000000000000000000000006a0000
-- 007:51e61051e6d6000000000000000000000000000000000000000000000000000000000000000000000000000000000000c90000
-- </TRACKS>

-- <PALETTE>
-- 000:140c1c40243430346d4a4a4a854c30346524d04648757161202020d27d2c8595aa6daa2c1ce68d6dc2cadad45eeaeed6
-- </PALETTE>

-- <COVER>
-- 000:2f7000007494648373160f0088003b00000000000442430343d6a4a4a458c4034356420d64845717164344d62dd7c258591ad6aac2c16ed8d62cacad4de5edee6dc2000000000f0088000040ff0b8c94badb83bedcbbff0682e84696e986aaeac6beeb07c2fc47d6fd87eafec7feff0c0a0784c2a1f88c4a279cc6a3f90d8a47a4daa592f8ca52bad207f1e5e65eb31178520623abb7d67dab06c6c7e1f3f87e6f4b65f8ecbbff336626a667585687071638888708e8d29827d758c6780746b7c7e5a859f8e97266277979b557e798a619f9bacadaeafa0b1b2b3b4b5b6b7b8b9babbbcbdbebfb0c1cf9f54c5c6c7c8c9cacbcccdcecfc0d1d2d3d4dec207d8d9dadbdcdddedfd0e1e2e3e4e5e6e7e8e9eaeed2cde13be0f1f2f3f4f5f6f7f8f9fafbfcfdfefff0030a0c1840b0a1c388031a2c58c0b1a3c780132a4c9841b2a5cb881332c366a1b3a74a7fcffe3a8c191eaa19c39821d11b49c2b5a7b26e236ac410f566adcb98337aecd9c3b7afcf90438a0d1a44b8a1d3a8439a2de7c069a35d7d0a963db635f3e20e6757b56d7acd832a39a7d2aa2470e0a0095700e2be28208d4d2bdb6e69be6b097e818850b909ca952bfd6da085bf6df2068bc670375395eeea00cb905f8833cd6528638c279cda43706de65548e83da4ec649ffe7eac69f2793dca83368e5d3a9479ec2f571bcedceab6783eb6b37b834b2087f8cda0a1bae6d7ebb7b7c8b07907b55e3c1fd9d3bd150f769e18b07be6e4fc10102bbddae576df61bbd3decdb83640f39fab8f97ad908b73f611d3865fbe5ed37cd5ff9a28dfcfbfbffffcf50400eff0840618ff5e75ec1030828b0e28a0238f0e3830438704042125871648d0268b1a6801e288029370c78e029832a9861a9832e4801ea8d1ab8d22a812a83a26d8c22b85120463eb8b36c873a38332d8d1a3834ea8f16e8ff46844e19a4a1973a39416091e0c8836f8c26a8f3e989525952e6923a49ed859d5eb861a79662f8766b806e73726b9e6eb9f66a807ec9476d9d6ea9876e9a7e34e5de9141d5e7ae48850a9499648a1503d1a845d4a863ae8e3a0964a29e4a0623a69e5a0b1d4c5cc5a9e6a4396389675b968ad9e307d03a49e9a6ae7a99a9a99aaaba67ad5563daa8aaae9a0aebaa9edacaeaaeb6cae8a7a8d4da4ca0b6caea3710b6beeaf96ea1b6ffbaeb23bfb62bace1a89e4bece0b8ca6b5216b5daca2d6d48ae6b39aea5ce8ae92aa4d29bcb28b4be1bcbaba1d23b9a6db6fedb8f6ebafeebcf6fbefefb00b845000710f638428370b2431c20c073c4030c67e98015605036360c5c71f3781f5c31360f0ffbb1b6c81b444175c7d8107dc3772334e0f3c1040062b638237333b2c4103c9d0cc13b00b17fce37dc9fc002080df136351063f2f879d0c79d430d4f735330d0fc664b9a3e47850e0b5a5b8302663f37fcefc6a547ec93bec1e007367ac0dd73d04bde634db13839046337f73c0cdd55b635c13d8d8bdd676d414833167d61773257e395c006a6ad7d42d20cbc66f9dd0383e0810593e76873060cff5da51637972057b730a38e0e030e089e7735eb634da93bbe9b959ab7338f59583dc16b8d2e04ee8f3660c20db7ad79b5ec7b5ca937ef7d1f307ac69720e048ecd43fdc79e7af9e97b7d79783b9b10f0430fdebe7af305df53308b724b7d68bf33bf489dc88cd8ee80329eb7cfc8baced8fde7b8620c0c295fc4a3733734f3737ed630f61e33e85ec276c9e68dfc575188dd538d78d89d97de07723a0ad3a62b591c52c47719bd6860bd23935d16eae76c39c40ea2827b1d9a0b4750cedcd7648bd8fb583e48114ad98fac7613b027c8f12cab1e70b17ee39ddce274e0bbdcaeae78531d8ef62093c07400308c24706730d2c791e5fdc87ce0626d0f78343c1ff2a096661ca749f0789e35fd3e83824c4fdf5a56fd0a22519d6f43c0cac8764f0aa1d3ea6854e6cb52c356423a71976a3c032b36d2484df512f0968c44222719a8c64232f19e8c8424272929ca4252f2969cc4262739a9ce4612dd10a461010210ee915692949ee145a923597ac652b2f59bac85aa2769ea4956d29690b4c5ad23797bce52f2f79bbc06ae2789eb4166139890c446692799ccc66a33f990dc86a437a94dca6a53fa98dcc6a637b9cd4b62a2559ba407e737993e475a831691e4272a3bc9fac376c23d96e457eb39d90fc67ac3dd98fcb7ae33e9cf4b76f3be9005a72d3bb940d28a14f0a80d48a2471abf425693d1a6fc782c312a9e498a543ff2a81da86647c9715d8a7493ab156567414af1519684d493253969415aef468ab4f5a03d89ac476a7cca9623d6a6ccb9ae437ac3556af417af3dd9605b7a04d2a2d4f8a84d4aa2519a34d6aa1598a24d7aa353aa4558aa557aa75d7ae257bac5deaa751b920d57a857e936dc7ef33ca46d4ba95b5a10d2bee39da86d5b6b55daf6d9bac570af5dcbae57fa74d492b475a41529a0655a38dfb61630b48d4ca1651b88d5ca36b1b09d98a46dfa195ace469dac7dcca6673bdd400876f3b0ad0da8674b4ad2da96f4b8ad4daa675bcad6dab6f5b0bd8dac676b4bd1de88e3b7b5fc6e694bbbdad200e00fb50e286b7bba51e2c698bebd4ea2779b7ad319d6bd41c7adcda07f6b0dd0d657d9b1cdfda5757b8d5731775ab4cd9e2673ab0cdae297fbb6c56eaa77db3b51f64717b6c59ea673bb2f58f6c77ab4ed8f2c757bcd5bfee77eb0069fab750cdf57f2b7f0c8066da773bbdfd60797b0c8f5aeee690cf0600338d0cfe5703f7ffb516903f770cd0e40b8874c5a590f48d3c3f58ee575cb0ed80b673db7e5ff6c8bbb6dd1faa81fb33e1f29877c326d13f8f7cc0602b0978c44e22b19f8ce9d80000b3
-- </COVER>

