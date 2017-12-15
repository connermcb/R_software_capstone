## geom_timeline

#' @title \code{GeomTIMELINE}
#' 
#' @description 
#' \code{ggproto} object based on \code{GeomPOINT} as plotting function for 
#' \code{geom_time} a ggplot compatible geom for plotting time sequence data
#' from the NOAA significant earthquake dataset.
#' 
#' @import ggplot2
#' @import grid
#' 
#' 
Geom_Hurricane <- ggproto("GeomTimeline", ggplot2::Geom,
                          required_aes = c("x", "y"),
                          default_aes = ggplot2::aes(colour=NA,
                                                     fill=NA,
                                                     size=0.5,
                                                     alpha=0.7,
                                                     ),
                          draw_key = ggplot::draw_key_point,
                          draw_group = function(data, panel_scales, coord){
                            
                            ## data formatting
                            
                            ## scale to plot panel
                            coords <- coord$transform(coords, panel_scales)
                            
                            grid::pointsGrob(
                              x = coords$x,
                              y = coords$y,
                              gp = grid::gpar(col = data[1,]$colour, 
                                              fill = data[1,]$fill, 
                                              alpha = data[1,]$alpha))
                          }
)

