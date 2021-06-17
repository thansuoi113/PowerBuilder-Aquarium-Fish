$PBExportHeader$w_fish.srw
forward
global type w_fish from window
end type
type p_4 from picture within w_fish
end type
type p_5 from picture within w_fish
end type
type p_3 from picture within w_fish
end type
type p_2 from picture within w_fish
end type
type p_1 from picture within w_fish
end type
type s_fish from structure within w_fish
end type
end forward

type s_fish from structure
	picture		p_pict
	integer		i_pos
	integer		i_dist
	boolean		b_right
	boolean		b_visible
end type

shared variables
 
end variables

global type w_fish from window
integer y = 4
integer width = 2071
integer height = 1908
boolean titlebar = true
string title = "Aquarium Fish"
string menuname = "m_fish"
boolean controlmenu = true
boolean resizable = true
windowtype windowtype = popup!
long backcolor = 8388608
p_4 p_4
p_5 p_5
p_3 p_3
p_2 p_2
p_1 p_1
end type
global w_fish w_fish

type variables
Public:
Double	idb_Interval = 0.075
Integer	ii_Delta = 0

Private:
/*  Object Structure references must be
     declared as private  */
s_fish	istr_Fish[5]
end variables

forward prototypes
public function integer of_addremovefish (readonly integer ai_index, readonly boolean ab_visible)
public function integer of_getfishvisible (readonly integer ai_index)
public function integer wf_center ()
end prototypes

public function integer of_addremovefish (readonly integer ai_index, readonly boolean ab_visible);istr_Fish[ai_index].b_Visible = ab_visible
istr_Fish[ai_index].p_pict.Visible = ab_visible

Return 1
end function

public function integer of_getfishvisible (readonly integer ai_index);If istr_fish[ai_index].b_visible Then
	return 0
Else
	return 1
End If
end function

public function integer wf_center ();//*-----------------------------------------------------------------*/
//*    f_Center:  Center the window
//*-----------------------------------------------------------------*/
int li_screenheight, li_screenwidth, li_rc, li_x=1, li_y=1
environment	lenv_obj

/*  Check for a window association with this object  */
If IsNull ( this ) Or Not IsValid ( this ) Then Return -1

/*  Get environment  */
If GetEnvironment ( lenv_obj ) = -1 Then Return -1

/*  Determine current screen resolution and validate  */
li_screenheight = PixelsToUnits ( lenv_obj.ScreenHeight, YPixelsToUnits! )
li_screenwidth  = PixelsToUnits ( lenv_obj.ScreenWidth, XPixelsToUnits! )
If Not ( li_screenheight > 0 ) Or Not ( li_screenwidth > 0 ) Then Return -1

/*  Get center points  */
If li_screenwidth > this.Width Then
	li_x = ( li_screenwidth / 2 ) - ( this.Width / 2 )
End If
If li_screenheight > this.Height Then
	li_y = ( li_screenheight / 2 ) - ( this.Height / 2 )
End If

/*  Center window  */
li_rc = this.Move ( li_x, li_y )
If li_rc <> 1 Then Return -1

Return 1
end function

event timer;//Timer script for w_fish

// Loop thru the 5 fish, changing each fish's position.
// At boundary conditions, change bitmap to left (fish?l)
// or right (fish?r) fish as appropriate.

Integer li_Cnt, li_Dist

For li_Cnt = 1 To 5
	
	If istr_Fish[li_Cnt].b_visible = False &
		And istr_Fish[li_Cnt].p_pict.Visible = True Then
		istr_Fish[li_Cnt].p_pict.Visible = False
		This.SetRedraw ( True )
		Continue
	End If
	
	If (istr_Fish[li_Cnt].i_Dist + ii_Delta) > 16 Then
		li_Dist = 16
	ElseIf (istr_Fish[li_Cnt].i_Dist + ii_Delta) < 2 Then
		li_Dist = 2
	Else
		li_Dist = istr_Fish[li_Cnt].i_Dist + ii_Delta
	End If
	
	If istr_Fish[li_Cnt].b_Right Then
		istr_Fish[li_Cnt].i_Pos = istr_Fish[li_Cnt].i_Pos + li_Dist
		istr_Fish[li_Cnt].p_pict.Draw(istr_Fish[li_Cnt].i_Pos, istr_Fish[li_Cnt].p_pict.Y)
		
		If ((istr_Fish[li_Cnt].i_Pos + istr_Fish[li_Cnt].p_pict.Width) > This.Width) And &
			istr_Fish[li_Cnt].b_visible Then
			// At right edge of screen, turn fish
			istr_Fish[li_Cnt].p_pict.PictureName = "fish" + String(li_Cnt) + "l.bmp"
			istr_Fish[li_Cnt].b_Right = False
			
			If istr_Fish[li_Cnt].i_Pos > This.Width Then
				// Fish is past right edge of window, move it back
				istr_Fish[li_Cnt].i_Pos = This.Width
			End If
		End If
	Else
		istr_Fish[li_Cnt].i_Pos = istr_Fish[li_Cnt].i_Pos - li_Dist
		istr_Fish[li_Cnt].p_pict.Draw(istr_Fish[li_Cnt].i_Pos, istr_Fish[li_Cnt].p_pict.Y)
		
		If istr_Fish[li_Cnt].i_Pos < 0 And istr_Fish[li_Cnt].b_visible Then
			// At left edge of screen, turn fish
			istr_Fish[li_Cnt].p_pict.PictureName = "fish" + String(li_Cnt) + "r.bmp"
			istr_Fish[li_Cnt].b_Right = True
			
			If (istr_Fish[li_Cnt].i_Pos + istr_Fish[li_Cnt].p_pict.Width) < 0 Then
				// Fish is past left edge of window, move it back
				istr_Fish[li_Cnt].i_Pos = 0 - istr_Fish[li_Cnt].p_pict.Width
			End If
		End If
	End If
Next


end event

event open;wf_Center()

//Open script for w_fish

Integer	li_Cnt

// Initialize picture array to the five pictures of fish, visible to
// the right of the visible window. To see these, expand the window to
// the right.
istr_Fish[1].p_Pict = p_1
istr_Fish[2].p_Pict = p_2
istr_Fish[3].p_Pict = p_3
istr_Fish[4].p_Pict = p_4
istr_Fish[5].p_Pict = p_5

// Randomize the fish speed and move them
// off the left side of the screen.
Randomize(0)

For li_Cnt = 1 To 5
	istr_Fish[li_Cnt].i_Dist = Rand(9) + 3
	If li_Cnt > 1 Then
		If istr_Fish[li_Cnt].i_Dist = istr_Fish[li_Cnt - 1].i_Dist Then
			istr_Fish[li_Cnt].i_Dist = istr_Fish[li_Cnt].i_Dist + 2
		End If
	End If
	
	istr_Fish[li_Cnt].p_Pict.X = -732
	istr_Fish[li_Cnt].i_Pos = istr_Fish[li_Cnt].p_Pict.X
	istr_Fish[li_Cnt].b_Right = True
	istr_Fish[li_Cnt].b_Visible = True
Next

// Start them swimming.
Timer(idb_Interval)



end event

on w_fish.create
if this.MenuName = "m_fish" then this.MenuID = create m_fish
this.p_4=create p_4
this.p_5=create p_5
this.p_3=create p_3
this.p_2=create p_2
this.p_1=create p_1
this.Control[]={this.p_4,&
this.p_5,&
this.p_3,&
this.p_2,&
this.p_1}
end on

on w_fish.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.p_4)
destroy(this.p_5)
destroy(this.p_3)
destroy(this.p_2)
destroy(this.p_1)
end on

event close;//Close script for w_fish

If IsValid(w_fish_config) Then
	Close(w_fish_config)
End If


end event

type p_4 from picture within w_fish
integer x = 2030
integer y = 988
integer width = 731
integer height = 484
boolean originalsize = true
string picturename = "fish4r.bmp"
end type

type p_5 from picture within w_fish
integer x = 2030
integer y = 1436
integer width = 731
integer height = 484
boolean originalsize = true
string picturename = "fish5r.bmp"
end type

type p_3 from picture within w_fish
integer x = 2030
integer y = 620
integer width = 731
integer height = 484
boolean originalsize = true
string picturename = "fish3r.bmp"
end type

type p_2 from picture within w_fish
integer x = 2030
integer y = 268
integer width = 731
integer height = 484
boolean originalsize = true
string picturename = "fish2r.bmp"
end type

type p_1 from picture within w_fish
integer x = 2030
integer width = 731
integer height = 484
boolean originalsize = true
string picturename = "fish1r.bmp"
end type

