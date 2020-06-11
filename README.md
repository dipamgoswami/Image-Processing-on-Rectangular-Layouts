## Image Processing on Rectangular Layouts using Matlab

Image Processing problems involve the recognition of certain features from the image provided by the user. This project involves the recognition of the rectangular layout from the image and detection of the horizontal and vertical edges from the layout. The Image Processing algorithms are implemented using the MATLAB Software and its image processing tools.

For the Recatangular layout here:

![layout](https://user-images.githubusercontent.com/40790714/84437156-2c5fe800-ac52-11ea-9622-87089680fefd.png)

We get these Vertical and Horizontal lines:

![hor](https://user-images.githubusercontent.com/40790714/84437421-94163300-ac52-11ea-8f7b-613e3060818c.png)
![ver](https://user-images.githubusercontent.com/40790714/84437428-96788d00-ac52-11ea-9d3f-64f6089f246a.png)

The objective is to obtain the encoded matrix from the rectangular layout, depicting the indexing of the rectangles and their adjacency relations using the grids formed by the vertical and horizontal lines and then obtain the dimensions of all the rectangles. The dimensions of the rectangles will be used to find their aspect ratio which can be used in many different problems. 

The encoded matrix corresponding to the Rectangular layout above is:
     1     9     9     9     9     9     9
     1     2     5     5     5     7    10
     1     2     3     4     6     7    10
     1     2     8     8     8     8    10
     1     2    11    11    11    11    11
     1    12    12    12    12    12    12

To get a better perspective of the Project, go through the Image_Processing_Rectangular_Layouts Doc file in this repository.
