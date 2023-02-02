Class IRISLOG.InitalData Extends %RegisteredObject
{

/// pPath为安装文件路径
ClassMethod Run(pPath)
{
    Kill ^Ens.Util.LogD
    Kill ^Ens.Util.LogI
    Do $system.OBJ.Load(pPath_"\log1.gof")
    Do $system.OBJ.Load(pPath_"\log2.gof")
    Do $system.OBJ.Load(pPath_"\msgbody.gof")
    Do $system.OBJ.Load(pPath_"\msghead1.gof")
    Do $system.OBJ.Load(pPath_"\msghead2.gof")
}

}
