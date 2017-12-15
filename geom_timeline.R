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


#' @title Plot Hurricane Wind Speed/Radii Data
#' 
#' @description
#' \code{geom_hurricane} is a ggplot2 plotting layer designed to plot hurrican wind 
#' speed distributions as radii corresponding to the geographic reach of a 
#' particular wind speed in the four cartesian quadrants. Hurricane wind 
#' radii report how far winds of a certain intensity (e.g., 34, 50, or 64 knots)
#' extended from a hurricane's center, with separate values reported for the 
#' northeast, northwest, southeast, and southwest quadrants of the storm. 
#' 
#' These wind radii are available for Atlantic basin tropical storms since 1988 
#' through the Extended Best Tract dataset, available here: 
#' \link{http://rammb.cira.colostate.edu/research/tropical_cyclones/tc_extended_best_track_dataset/}
#' 
#' @import dplyr
#' @import geosphere
#' @import ggmap
#' @import ggplot2
#' @import grid
#' @import lubridate
#' @import png
#' @import reshape
#' @import tidyr
#' 
#' @param mapping vector of aesthetic values - x and y plot coordinates, group
#' variable, colour, fill, linetype, size, alpha.
#' @param data dataframe preprocessed using \code{get_hrcn_data}.
#' @param stat transformation function
#' @param position 
#' @param na.rm boolean switch for removing NA values or not
#' @param show.legend
#' @param inherit.aes
#' @param scale_radii plot scaling factor (0, 1] 
#' 
#' @return ggplot2 object plot layer
#' 
#' @import tidyr
#' @import dplyr
#' @import geosphere
#' 
#' @export
geom_timeline <-  function (mapping = NULL,
                            data = NULL,
                            stat = "identity",
                            position = "identity",
                            na.rm = FALSE,
                            show.legend = NA,
                            inherit.aes = TRUE,
                            scale_radii=1,...){
  ## create plot layer with processed data
  ggplot2::layer(data = data, mapping = mapping, stat = stat,
                 geom = Geom_Timeline, position = position,
                 show.legend = show.legend, inherit.aes = inherit.aes,
                 params = list(na.rm = na.rm, ...))
}

