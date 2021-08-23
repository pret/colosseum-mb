STD_REVERB = 0

$(MID_SUBDIR)/se_select.s: %.s: %.mid
	$(MID) $< $@ -E -R$(STD_REVERB) -G127 -V127 -P10

$(MID_SUBDIR)/se_failure.s: %.s: %.mid
	$(MID) $< $@ -E -R$(STD_REVERB) -G127 -V127 -P10
