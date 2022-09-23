import sys

def exercise1(attributes, classes):
    print("Activity 1")
    # Your code here

def exercise2(attributes, classes):
    print("Activity 2")
    # Your code here
    
def exercise3(attributes, classes):
    print("Activity 3")
    # Your code here
        
def exercise4(attributes, classes):
    print("Activity 4")
    # Your code here
        
def read_and_process_data(filename):
    # Your code here
        
def pec2(filename):     
    # Read and process data
    attributes, classes = read_and_process_data(filename)

    print('###################################################################')
    exercise1(attributes, classes) 
    print('###################################################################')
    exercise2(attributes, classes) 
    print('###################################################################')
    exercise3(attributes, classes) 
    print('###################################################################')
    exercise4(attributes, classes)                            
        
if __name__ == '__main__':
    print('IAA: PEC2')
    if len(sys.argv) > 1:
        filename = sys.argv[1]
    else: 
        filename = '../ionosphere/ionosphere.data'
        
    pec2(filename)              