
#include "GLShaderManager.h"
/*
 `#include<GLShaderManager.h>` 移入了GLTool 着色器管理器（shader Mananger）类。没有着色器，我们就不能在OpenGL（核心框架）进行着色。着色器管理器不仅允许我们创建并管理着色器，还提供一组“存储着色器”，他们能够进行一些初步䄦基本的渲染操作。
 */

#include "GLTools.h"
/*
 `#include<GLTools.h>`  GLTool.h头文件包含了大部分GLTool中类似C语言的独立函数
*/

 
#include <GLUT/GLUT.h>
/*
 在Mac 系统下，`#include<glut/glut.h>`
 在Windows 和 Linux上，我们使用freeglut的静态库版本并且需要添加一个宏
*/

//定义一个，着色管理器
GLShaderManager shaderManager;

//简单的批次容器，是GLTools的一个简单的容器类。
GLBatch triangleBatch;

GLfloat blockSize = 0.06f;

GLfloat vVerts[] = {
    -blockSize,-blockSize,0.f,
    blockSize,-blockSize,0.0f,
    blockSize,blockSize,0.0f,
    -blockSize,blockSize,0.0f
};
/*
 在窗口大小改变时，接收新的宽度&高度。
 */
void changeSize(int w,int h)
{
    /*
      x,y 参数代表窗口中视图的左下角坐标，而宽度、高度是像素为表示，通常x,y 都是为0
     */
    glViewport(0, 0, w, h);
    
}
//渲染
void RenderScene(void)
{
    //执行清空颜色缓冲区
    glClear(GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT|GL_STENCIL_BUFFER_BIT);
    GLfloat vGreen[] = {0.0f,1.0f,0.0f,1.0f};
    shaderManager.UseStockShader(GLT_SHADER_IDENTITY,vGreen);
    triangleBatch.Draw();
    glutSwapBuffers();
}

void SpeacialKeys(int key,int x,int y)
{
    //D点位
    GLfloat stepSize = 0.025f;
    GLfloat blockX = vVerts[0];
    GLfloat blockY = vVerts[10];
    
    if (key == GLUT_KEY_UP) {
        blockY+=stepSize;
    }
    if (key == GLUT_KEY_DOWN) {
        blockY-=stepSize;
    }
    if (key == GLUT_KEY_LEFT) {
        blockX-=stepSize;
    }
    if (key == GLUT_KEY_RIGHT) {
        blockX+=stepSize;
    }
    
//    A点
    vVerts[0] = blockX;
    vVerts[1] = blockY-blockSize*2;
    
    vVerts[3] = blockX+blockSize*2;
    vVerts[4] = blockY-blockSize*2;
    
    vVerts[6] = blockX+blockSize*2;
    vVerts[7] = blockY;
    
    vVerts[9] = blockX;
    vVerts[10] = blockY;
    
    triangleBatch.CopyVertexData3f(vVerts);
    triangleBatch.Draw();
    glutPostRedisplay();
}

void setupRC()
{
   //清理窗口颜色 颜色  颜色缓冲区里
    glClearColor(0.98f, 0.4f, 0.7f, 1.0f);
    //初始化着色器管理器
    shaderManager.InitializeStockShaders();
    //定点坐标
//    GLfloat verts[] = {
//      -0.5f,0.0f,0.0f,
//      0.5f,0.0f,0.0f,
//      0.0f,0.5f,0.0f
//    };
//
    //
    triangleBatch.Begin(GL_TRIANGLE_FAN, 4);
    triangleBatch.CopyVertexData3f(vVerts);
    triangleBatch.End();
    
}

int main(int argc,char *argv[])
{
    //设置当前工作目录，针对MAC OS X
    /*
     `GLTools`函数`glSetWorkingDrectory`用来设置当前工作目录。实际上在Windows中是不必要的，因为工作目录默认就是与程序可执行执行程序相同的目录。但是在Mac OS X中，这个程序将当前工作文件夹改为应用程序捆绑包中的`/Resource`文件夹。`GLUT`的优先设定自动进行了这个中设置，但是这样中方法更加安全。
     */
    gltSetWorkingDirectory(argv[0]);
    
    
    //初始化GLUT库,这个函数只是传说命令参数并且初始化glut库
    glutInit(&argc, argv);
    
    
    glutInitDisplayMode(GLUT_RGBA);
    
    //GLUT窗口大小、窗口标题
    glutInitWindowSize(800, 600);
    glutCreateWindow("Triangle");
    
    
    /*
     GLUT 内部运行一个本地消息循环，拦截适当的消息。然后调用我们不同时间注册的回调函数。我们一共注册2个回调函数：
     1）为窗口改变大小而设置的一个回调函数
     2）包含OpenGL 渲染的回调函数
     */
    
    //注册重塑函数
    glutReshapeFunc(changeSize);
    //注册显示函数
    glutDisplayFunc(RenderScene);

    glutSpecialFunc(SpeacialKeys);
    
    /*
     初始化一个GLEW库,确保OpenGL API对程序完全可用。
     在试图做任何渲染之前，要检查确定驱动程序的初始化过程中没有任何问题
     */
    GLenum status = glewInit();
    if (GLEW_OK != status) {
        
        printf("GLEW Error:%s\n",glewGetErrorString(status));
        return 1;
        
    }
    
    //设置我们的渲染环境
    setupRC();
    
    glutMainLoop();
    
    return  0;
    
}
