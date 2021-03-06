"""
	grdcut(cmd0::String="", arg1=[], kwargs...)

Produce a new outgrid file which is a subregion of ingrid. The subregion is specified with
``limits`` (the -R); the specified range must not exceed the range of ingrid (but see ``extend``).

Full option list at [`grdcut`](http://gmt.soest.hawaii.edu/doc/latest/grdcut.html)

Parameters
----------

- **G** : **outgrid** : -- Str --

    Output grid file name. Note that this is optional and to be used only when saving
    the result directly on disk. Otherwise, just use the G = grdcut(....) form.
    [`-G`](http://gmt.soest.hawaii.edu/doc/latest/grdcut.html#g)
- $(GMT.opt_J)
- **N** : **extend** : -- Str or [] --

    Allow grid to be extended if new region exceeds existing boundaries. Append nodata value
    to initialize nodes outside current region [Default is NaN].
    [`-N`](http://gmt.soest.hawaii.edu/doc/latest/grdcut.html#n)
- $(GMT.opt_R)
- **S** : **circ_subregion** : -- Str --    Flags = [n]lon/lat/radius[unit]

    Specify an origin and radius; append a distance unit and we determine the corresponding
    rectangular region so that all grid nodes on or inside the circle are contained in the subset.
    [`-S`](http://gmt.soest.hawaii.edu/doc/latest/grdcut.html#s)
- $(GMT.opt_V)
- **Z** : **z_subregion** : -- Str --       Flags = [n|N |r][min/max]

    Determine a new rectangular region so that all nodes outside this region are also outside
    the given z-range.
    [`-Z`](http://gmt.soest.hawaii.edu/doc/latest/grdcut.html#z)
- $(GMT.opt_f)
"""
function grdcut(cmd0::String="", arg1=[]; kwargs...)

	length(kwargs) == 0 && return monolitic("grdcut", cmd0, arg1)

    d = KW(kwargs)
    if (GMTver < 6)  cmd = parse_common_opts(d, "", [:R :V_params :f])
    else             cmd = parse_common_opts(d, "", [:R :J :V_params :f])
    end
    cmd = parse_these_opts(cmd, d, [[:G :outgrid], [:N :extend], [:S :circ_subregion], [:Z :z_subregion]])

	cmd, got_fname, arg1 = find_data(d, cmd0, cmd, 1, arg1)
	return common_grd(d, cmd, got_fname, 1, "grdcut", arg1)		# Finish build cmd and run it
end

# ---------------------------------------------------------------------------------------------------
grdcut(arg1=[], cmd0::String=""; kw...) = grdcut(cmd0, arg1; kw...)