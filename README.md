# article-source-code
Here are the source matlab codes of an article named "Structural optimum design of single-layer domes using modified artificial bee colony algorithm with surrogate-based neural network model",the code is used for the optimum design of single-layer domes using artificial bee colony algorithm(ABC), and instead of time-consuming finite element method(FEM) process, deep artificial neural network is trained to surrogate the FEM process of the ABC iteration, as a contrast, whale optimization algorithm(WOA) and grey wolf optimizer(GWO) are introduced into this method.
The codes includes three basic numerical examples: 10-bar truss, lamella dome and kiewit dome, for each includes these parts:
1.Data generation using ANSYS(.mac);
2.Train the network;
3.Optimize structure using ABC, WOA, and GWO;
4.Using network to surrogate the FEM process of the above methods.
To run the codes,you need:
1.MATLAB(better R2018a);
2.ANSYS Mechanical APDL 15.0;
These codes are uploaded for references of beginners, if any questions or suggestions, welcome to email:904347574@qq.com. if it is useful for you, please star me.
Thank you.
