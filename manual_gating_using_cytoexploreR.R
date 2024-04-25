# CD19 Gating
cyto_gate_draw(fs,
               select=cyto_select(fs,replica="79"),
               parent="root",
               channels=c("CD19","7AAD"),
               alias=c("B-cells","T-cells"),
               xlim=c(-1e5,1e6),
               ylim=c(-1e5,1e6),
               type=c("interval"),
               negate=TRUE)

#B cells IgM, IgD gating
cyto_gate_draw(fs,
               select=cyto_select(fs,replica="79"),
               parent="B-cells",
               channels=c("CD8_IgD","IgM"),
               alias=c("IgD_CD8+IgM+","IgD_CD8-IgM+","IgD_CD8-IgM-"),
               xlim=c(-1e5,1e6),
               ylim=c(-1e5,1e6),
               type=c("rectangle","rectangle","rectangle"),
               contour_lines = 10,
               contour_line_type = 1,
               contour_line_width = 1.2,
               contour_line_col = "black",
               contour_line_alpha = 0.2)

#T cells CD4, CD8 gating
cyto_gate_draw(fs,
               select=cyto_select(fs,replica="79"),
               parent="T-cells",
               channels=c("CD8_IgD","CD4"),
               alias=c("CD8_IgD+","CD4+","CD4-CD8-"),
               xlim=c(-1e5,1e6),
               ylim=c(-1e5,1e6),
               type=c("polygon","polygon","polygon"),
               contour_lines = 10,
               contour_line_type = 1,
               contour_line_width = 1.2,
               contour_line_col = "black",
               contour_line_alpha = 0.2)
