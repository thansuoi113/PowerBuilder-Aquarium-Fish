$PBExportHeader$w_fish_config.srw
forward
global type w_fish_config from window
end type
type st_speed from statictext within w_fish_config
end type
type lv_1 from listview within w_fish_config
end type
type st_2 from statictext within w_fish_config
end type
type cb_close from commandbutton within w_fish_config
end type
type hsb_speed from hscrollbar within w_fish_config
end type
type st_4 from statictext within w_fish_config
end type
type st_1 from statictext within w_fish_config
end type
type s_fish from structure within w_fish_config
end type
end forward

type s_fish from structure
	picture		p_pict
	integer		i_pos
	integer		i_dist
	boolean		b_right
	boolean		b_visible
end type

global type w_fish_config from window
integer x = 2098
integer y = 20
integer width = 841
integer height = 1404
boolean titlebar = true
string title = "Configure Aquarium"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 81838264
toolbaralignment toolbaralignment = alignatleft!
st_speed st_speed
lv_1 lv_1
st_2 st_2
cb_close cb_close
hsb_speed hsb_speed
st_4 st_4
st_1 st_1
end type
global w_fish_config w_fish_config

type variables
w_fish w_aquarium
end variables

forward prototypes
public subroutine of_change_speed (integer ai_position)
public function integer wf_center ()
end prototypes

public subroutine of_change_speed (integer ai_position);// Function to change the speed of the fish.

ai_Position = ai_Position - 4

Choose Case ai_Position
	Case -4, -3
		st_speed.Text = "Drifting"
	Case -2 To -1
		st_speed.Text = "Pokey"
	Case 0
		st_speed.Text = "Normal"
	Case 1, 2
		st_speed.Text = "Zippy"
	Case 3, 4
		st_speed.Text = "Flying"
End Choose

w_aquarium.ii_Delta = ai_Position * 2

end subroutine

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

on w_fish_config.create
this.st_speed=create st_speed
this.lv_1=create lv_1
this.st_2=create st_2
this.cb_close=create cb_close
this.hsb_speed=create hsb_speed
this.st_4=create st_4
this.st_1=create st_1
this.Control[]={this.st_speed,&
this.lv_1,&
this.st_2,&
this.cb_close,&
this.hsb_speed,&
this.st_4,&
this.st_1}
end on

on w_fish_config.destroy
destroy(this.st_speed)
destroy(this.lv_1)
destroy(this.st_2)
destroy(this.cb_close)
destroy(this.hsb_speed)
destroy(this.st_4)
destroy(this.st_1)
end on

event open;wf_center()

Integer	li_1, li_2, li_3, li_4, li_5, li_Overlay, li_Position
ListViewItem	llvi_Item

w_aquarium = Message.PowerObjectParm

// Add the fish pictures to the ListView
lv_1.SmallPictureWidth = 57
lv_1.SmallPictureHeight = 39

li_1 = lv_1.AddSmallPicture("fish1r.bmp")
li_2 = lv_1.AddSmallPicture("fish2r.bmp")
li_3 = lv_1.AddSmallPicture("fish3r.bmp")
li_4 = lv_1.AddSmallPicture("fish4r.bmp")
li_5 = lv_1.AddSmallPicture("fish5r.bmp")
li_Overlay = lv_1.AddSmallPicture("NotFound!")

lv_1.SetOverlayPicture(1, li_Overlay)

lv_1.AddColumn("fish", Left!, 700)

llvi_Item.Label = "Clownfish"
llvi_Item.PictureIndex = li_1
llvi_Item.OverlayPictureIndex = w_aquarium.of_GetFishVisible ( li_1 )
lv_1.AddItem ( llvi_Item )

llvi_Item.Label = "Clown Triggerfish"
llvi_Item.PictureIndex = li_2
llvi_Item.OverlayPictureIndex = w_aquarium.of_GetFishVisible ( li_2 )
lv_1.AddItem ( llvi_Item )

llvi_Item.Label = "Emperor Anglefish"
llvi_Item.PictureIndex = li_3
llvi_Item.OverlayPictureIndex = w_aquarium.of_GetFishVisible ( li_3 )
lv_1.AddItem ( llvi_Item )

llvi_Item.Label = "Moorish Idol"
llvi_Item.PictureIndex = li_4
llvi_Item.OverlayPictureIndex = w_aquarium.of_GetFishVisible ( li_4 )
lv_1.AddItem ( llvi_Item )

llvi_Item.Label = "Palette Tang"
llvi_Item.PictureIndex = li_5
llvi_Item.OverlayPictureIndex = w_aquarium.of_GetFishVisible ( li_5 )
lv_1.AddItem ( llvi_Item )

li_Position = ( w_aquarium.ii_Delta / 2 )

Choose Case li_Position
	Case -4, -3
		st_speed.Text = "Drifting"
	Case -2 To -1
		st_speed.Text = "Pokey"
	Case 0
		st_speed.Text = "Normal"
	Case 1, 2
		st_speed.Text = "Zippy"
	Case 3, 4
		st_speed.Text = "Flying"
End Choose

hsb_speed.Position = li_Position + 4



end event

type st_speed from statictext within w_fish_config
integer x = 439
integer y = 1000
integer width = 265
integer height = 64
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 75530304
boolean enabled = false
string text = "Normal"
long bordercolor = 8388608
boolean focusrectangle = false
end type

type lv_1 from listview within w_fish_config
integer x = 37
integer y = 148
integer width = 722
integer height = 828
integer taborder = 10
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16777215
long backcolor = 8388608
borderstyle borderstyle = stylelowered!
boolean buttonheader = false
boolean showheader = false
boolean scrolling = false
listviewview view = listviewreport!
integer largepicturewidth = 32
integer largepictureheight = 32
long largepicturemaskcolor = 553648127
integer smallpicturewidth = 16
integer smallpictureheight = 16
long smallpicturemaskcolor = 12632256
long statepicturemaskcolor = 536870912
end type

event doubleclicked;// Remove or add a fish to/from the aquarium

ListViewItem	llvi_Item

If index <=0 Then Return
If GetItem(index, llvi_Item) = -1 Then Return

If llvi_Item.OverlayPictureIndex = 0 Then
	llvi_Item.OverlayPictureIndex = 1
	
	// Remove the fish from the aquarium
	w_aquarium.of_AddRemoveFish ( index, False ) 
	
Else
	llvi_Item.OverlayPictureIndex = 0
	
	// Add the fish back to the aquarium
	w_aquarium.of_AddRemoveFish ( index, True ) 
End If

llvi_Item.Selected = False

SetItem(index, llvi_Item)

end event

type st_2 from statictext within w_fish_config
integer x = 37
integer y = 76
integer width = 425
integer height = 64
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 75530304
boolean enabled = false
string text = "include/exclude it:"
long bordercolor = 8388608
boolean focusrectangle = false
end type

type cb_close from commandbutton within w_fish_config
integer x = 279
integer y = 1172
integer width = 215
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Close"
end type

event clicked;Close(Parent)

end event

type hsb_speed from hscrollbar within w_fish_config
integer x = 37
integer y = 1064
integer width = 722
integer height = 52
integer maxposition = 8
integer position = 4
end type

event moved;of_change_speed(position)

end event

event lineleft;If This.Position > 0 Then
	This.Position = This.Position - 1
End If

of_change_speed(This.Position)

end event

event lineright;If This.Position < 8 Then
	This.Position = This.Position + 1
End If

of_change_speed(This.Position)

end event

event pageright;If This.Position < 7 Then
	This.Position = This.Position + 2
End If

of_change_speed(This.Position)

end event

event pageleft;If This.Position > 1 Then
	This.Position = This.Position - 2
End If

of_change_speed(This.Position)

end event

type st_4 from statictext within w_fish_config
integer x = 37
integer y = 1000
integer width = 416
integer height = 64
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 75530304
boolean enabled = false
string text = "Swimming Speed:"
long bordercolor = 8388608
boolean focusrectangle = false
end type

type st_1 from statictext within w_fish_config
integer x = 37
integer y = 20
integer width = 498
integer height = 64
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 41943040
long backcolor = 75530304
boolean enabled = false
string text = "Double-click a fish to"
long bordercolor = 8388608
boolean focusrectangle = false
end type

