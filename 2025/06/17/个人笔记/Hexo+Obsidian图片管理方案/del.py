import datetime
class MovieType:
    #属性
    tid=0
    tname=""
    tcontent=""
    tdate=datetime.datetime.now()

    #方法
    def __init__(self,tid1,tname1,tcontent1):
        self.tid=tid1
        self.tname=tname1
        self.tcontent=tcontent1

    