# Image-Processing-on-Rectangular-Layouts
Image Processing on Rectangular Layouts using Matlab

Image Processing problems involve the recognition of certain features from the image provided by the user. This project involves the recognition of the rectangular layout from the image and detection of the horizontal and vertical edges from the layout. The Image Processing algorithms are implemented using the MATLAB Software.

The objective is to obtain the encoded matrix from the rectangular layout, depicting the indexing of the rectangles and their adjacency relations using the grids formed by the vertical and horizontal lines and then obtain the dimensions of all the rectangles. The dimensions of the rectangles will be used to find their aspect ratio which can be used in many different problems. 

1.	Introduction –

The Image Processing Algorithm involves 5 major steps starting with the image provided by the user and finding the encoded matrix and the dimensions of all the rectangles. The image should necessarily be a rectangular layout which is the partition of a rectangle into a finite set of interior-disjoint rectangles. 

The first step is to convert the image to a binary image and then extract two images from the image provided, one containing only the vertical edges and the other one containing only the horizontal edges of the given rectangular layout. The next step is to find the coordinates at the end points as well as the intersection points of the vertical and horizontal edges. Then, the horizontal grid lines are obtained using the location of the horizontal edges in the image and similarly the vertical grid lines are obtained. After the grid lines are obtained, the indexing of the rectangles is done column-wise and their dimensions are stored along with their index. The Algorithm has been tested successfully on different images. The algorithm has been implemented using the sample image shown below.

 

