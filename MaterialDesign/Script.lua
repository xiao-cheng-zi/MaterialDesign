function Initialize()
    UpTime = 0
    DiskUpTime = tonumber(SKIN:GetVariable("DiskUpdateIntv"))
    -- CPU Table
    CpuInfoTable = {}
    CpuInfoTable.CpuTempCap = tonumber(SKIN:GetVariable("CpuTempCap"))
    CpuInfoTable.CpuFanRpmCap = tonumber(SKIN:GetVariable("CpuFanRpmCap"))
    CpuInfoTable.CpuPowerCap = tonumber(SKIN:GetVariable("CpuPowerCap"))
    CpuInfoTable.MinTempCol = 0
    CpuInfoTable.MaxTempCol = 0
    CpuInfoTable.CpuTempBarSize = 0
    CpuInfoTable.CpuUsageBarSize = 0
    CpuInfoTable.CpuFanBarSize = 0
    CpuInfoTable.CpuPowerBarSize = 0
    CpuInfoTable.CpuUsageHistBarSize1 = 0
    CpuInfoTable.CpuUsageHistBarSize2 = 0
    CpuInfoTable.CpuUsageHistData = 0

    -- GPU Table
    GpuInfoTable = {}
    GpuInfoTable.GpuTempCap = tonumber(SKIN:GetVariable("GpuTempCap"))
    GpuInfoTable.GpuFanRpmCap = tonumber(SKIN:GetVariable("GpuFanRpmCap"))
    GpuInfoTable.GpuPowerCap = tonumber(SKIN:GetVariable("GpuPowerCap"))
    GpuInfoTable.MinTempCol = 0
    GpuInfoTable.MaxTempCol = 0
    GpuInfoTable.GpuTempBarSize = 0
    GpuInfoTable.GpuUsageBarSize = 0
    GpuInfoTable.GpuFanBarSize = 0
    GpuInfoTable.GpuPowerBarSize = 0
    GpuInfoTable.GpuUsageHistBarSize1 = 0
    GpuInfoTable.GpuUsageHistBarSize2 = 0
    GpuInfoTable.GpuUsageHistData = 0

    -- RAM Table
    RamInfoTable = {}
    RamInfoTable.RamLoadBarSize = 0

    -- Disk Table
    DiskInfoTable = {}
    DiskInfoTable.DiskTempCap = tonumber(SKIN:GetVariable("DiskTempCap"))
    DiskInfoTable.Drive = Split(SKIN:GetVariable("DiskDrive"), ",")
    DiskInfoTable.Capacity = 0
    DiskInfoTable.Usage = 0
    DiskInfoTable.Used = 0
    DiskInfoTable.Free = 0
    DiskInfoTable.UsageBarSize = 0
    DiskInfoTable.TempBarSize = 0
    DiskInfoTable.FreeBarSize = 0
end

function Update()
    -- 初始化（生命周期内只执行一次）
    if UpTime == 0 then
        -- 获取CPU温度仪表盘尺寸
        CpuInfoTable.CpuTempBarSize = SKIN:GetMeasure("MeterCpuTempBarShape1H"):GetValue()
        -- 获取CPU使用率仪表盘尺寸
        CpuInfoTable.CpuUsageBarSize = SKIN:GetMeasure("MeterCpuUsageBarShape1W"):GetValue()
        -- 获取CPU风扇仪表盘尺寸
        CpuInfoTable.CpuFanBarSize = SKIN:GetMeasure("MeterCpuFanBarShape1W"):GetValue()
        -- 获取CPU功率仪表盘尺寸
        CpuInfoTable.CpuPowerBarSize = SKIN:GetMeasure("MeterCpuPowerBarShape1W"):GetValue()
        -- 获取CPU使用率直方图尺寸
        CpuInfoTable.CpuUsageHistBarSize1 = SKIN:GetMeasure("MeterCpuUsageHistShape1H"):GetValue()
        CpuInfoTable.CpuUsageHistBarSize2 = SKIN:GetMeasure("MeterCpuUsageHistShape2H"):GetValue()
        -- 创建CPU使用率直方图所需的数组
        CpuInfoTable.CpuUsageHistData = NewArr(31, CpuInfoTable.CpuUsageHistBarSize2)

        -- 获取GPU温度仪表盘尺寸
        GpuInfoTable.GpuTempBarSize = SKIN:GetMeasure("MeterGpuTempBarShape1H"):GetValue()
        -- 获取GPU使用率仪表盘尺寸
        GpuInfoTable.GpuUsageBarSize = SKIN:GetMeasure("MeterGpuUsageBarShape1W"):GetValue()
        -- 获取GPU风扇仪表盘尺寸
        GpuInfoTable.GpuFanBarSize = SKIN:GetMeasure("MeterGpuFanBarShape1W"):GetValue()
        -- 获取GPU功率仪表盘尺寸
        GpuInfoTable.GpuPowerBarSize = SKIN:GetMeasure("MeterGpuPowerBarShape1W"):GetValue()
        -- 获取GPU使用率直方图尺寸
        GpuInfoTable.GpuUsageHistBarSize1 = SKIN:GetMeasure("MeterGpuUsageHistShape1H"):GetValue()
        GpuInfoTable.GpuUsageHistBarSize2 = SKIN:GetMeasure("MeterGpuUsageHistShape2H"):GetValue()
        -- 创建GPU使用率直方图所需的数组
        GpuInfoTable.GpuUsageHistData = NewArr(31, GpuInfoTable.GpuUsageHistBarSize2)

        -- 获取RAM使用率仪表盘尺寸
        RamInfoTable.RamLoadBarSize = SKIN:GetMeasure("MeterRamLoadBarShape1H"):GetValue()

        -- 获取硬盘总空间大小
        DiskInfoTable.Capacity = CalcDiskCapacity(DiskInfoTable.Drive)
        -- 获取硬盘使用率仪表盘尺寸
        DiskInfoTable.UsageBarSize = SKIN:GetMeasure("MeterDiskUsageBarShape1W"):GetValue()
        -- 获取硬盘温度仪表盘尺寸
        DiskInfoTable.TempBarSize = SKIN:GetMeasure("MeterDiskTempBarShape1W"):GetValue()
        -- 获取硬盘可用空间仪表盘尺寸
        DiskInfoTable.FreeBarSize = SKIN:GetMeasure("MeterDiskFreeBarShape1W"):GetValue()
    end

    -- CPU 温度仪表盘
    SKIN:Bang("!SetOption", "MeterCpuTempBar", "Shape2",
        "Rectangle [MeterCpuTempBarShape2X:],[MeterCpuTempBarShape2Y:],[MeterCpuTempBarShape2W:]," ..
        CalcBarSize(SKIN:GetMeasure("MeasureCpuTempValueRaw"):GetValue(), CpuInfoTable.CpuTempCap,
            CpuInfoTable.CpuTempBarSize,
            true) .. " | Fill Color 219,236,248,255 | StrokeWidth 0")

    -- CPU 温度添加导零
    SKIN:Bang("!SetVariable", "CpuTemp", AddLeadingZeros(SKIN:GetMeasure("MeasureCpuTempValueRaw"):GetValue(), 2, 0))

    -- CPU 温度 当前最小值 和 当前最大值
    CalcMinMax("MeasureCpuTempValueRaw", "CpuTempMin", "CpuTempMax", CpuInfoTable, "MinTempCol", "MaxTempCol")

    -- CPU 使用率添加导零
    SKIN:Bang("!SetVariable", "CpuUsage", AddLeadingZeros(SKIN:GetMeasure("MeasureCpuUsageValueRaw"):GetValue(), 2, 0))

    -- CPU 功率添加导零
    SKIN:Bang("!SetVariable", "CpuPower", AddLeadingZeros(SKIN:GetMeasure("MeasureCpuPowerValueRaw"):GetValue(), 2, 2))

    -- CPU 使用率直方图
    ControlHist("MeasureCpuUsageValueRaw", "MeterCpuUsageHist", CpuInfoTable, "CpuUsageHistData",
        CpuInfoTable.CpuUsageHistBarSize2)

    -- CPU 使用率仪表盘
    SKIN:Bang("!SetOption", "MeterCpuUsageBar", "Shape2",
        "Rectangle [MeterCpuUsageBarShape2X:],[MeterCpuUsageBarShape2Y:]," ..
        CalcBarSize(SKIN:GetMeasure("MeasureCpuUsageValueRaw"):GetValue(), 100, CpuInfoTable.CpuUsageBarSize, false) ..
        ",[MeterCpuUsageBarShape2H:] | Fill Color 44,130,190,255 | StrokeWidth 0")

    -- CPU 风扇转速仪表盘
    SKIN:Bang("!SetOption", "MeterCpuFanBar", "Shape2",
        "Rectangle [MeterCpuFanBarShape2X:],[MeterCpuFanBarShape2Y:]," ..
        CalcBarSize(SKIN:GetMeasure("MeasureCpuFanValueRaw"):GetValue(), CpuInfoTable.CpuFanRpmCap,
            CpuInfoTable.CpuFanBarSize,
            false) ..
        ",[MeterCpuFanBarShape2H:] | Fill Color 44,130,190,255 | StrokeWidth 0")

    -- CPU 功率仪表盘
    SKIN:Bang("!SetOption", "MeterCpuPowerBar", "Shape2",
        "Rectangle [MeterCpuPowerBarShape2X:],[MeterCpuPowerBarShape2Y:]," ..
        CalcBarSize(SKIN:GetMeasure("MeasureCpuPowerValueRaw"):GetValue(), CpuInfoTable.CpuPowerCap,
            CpuInfoTable.CpuPowerBarSize,
            false) ..
        ",[MeterCpuPowerBarShape2H:] | Fill Color 44,130,190,255 | StrokeWidth 0")

    -- GPU 温度仪表盘
    SKIN:Bang("!SetOption", "MeterGpuTempBar", "Shape2",
        "Rectangle [MeterGpuTempBarShape2X:],[MeterGpuTempBarShape2Y:],[MeterGpuTempBarShape2W:]," ..
        CalcBarSize(SKIN:GetMeasure("MeasureGpuTempValueRaw"):GetValue(), GpuInfoTable.GpuTempCap,
            GpuInfoTable.GpuTempBarSize,
            true) .. " | Fill Color 219,236,248,255 | StrokeWidth 0")

    -- GPU 温度添加导零
    SKIN:Bang("!SetVariable", "GpuTemp", AddLeadingZeros(SKIN:GetMeasure("MeasureGpuTempValueRaw"):GetValue(), 2, 0))

    -- GPU 温度 当前最小值 和 当前最大值
    CalcMinMax("MeasureGpuTempValueRaw", "GpuTempMin", "GpuTempMax", GpuInfoTable, "MinTempCol", "MaxTempCol")

    -- GPU 使用率添加导零
    SKIN:Bang("!SetVariable", "GpuUsage", AddLeadingZeros(SKIN:GetMeasure("MeasureGpuUsageValueRaw"):GetValue(), 2, 0))

    -- GPU 功率添加导零
    SKIN:Bang("!SetVariable", "GpuPower", AddLeadingZeros(SKIN:GetMeasure("MeasureGpuPowerValueRaw"):GetValue(), 2, 2))

    -- GPU 使用率直方图
    ControlHist("MeasureGpuUsageValueRaw", "MeterGpuUsageHist", GpuInfoTable, "GpuUsageHistData",
        GpuInfoTable.GpuUsageHistBarSize2)

    -- GPU 使用率仪表盘
    SKIN:Bang("!SetOption", "MeterGpuUsageBar", "Shape2",
        "Rectangle [MeterGpuUsageBarShape2X:],[MeterGpuUsageBarShape2Y:]," ..
        CalcBarSize(SKIN:GetMeasure("MeasureGpuUsageValueRaw"):GetValue(), 100, GpuInfoTable.GpuUsageBarSize, false) ..
        ",[MeterGpuUsageBarShape2H:] | Fill Color 44,130,190,255 | StrokeWidth 0")

    -- GPU 风扇转速仪表盘
    SKIN:Bang("!SetOption", "MeterGpuFanBar", "Shape2",
        "Rectangle [MeterGpuFanBarShape2X:],[MeterGpuFanBarShape2Y:]," ..
        CalcBarSize(SKIN:GetMeasure("MeasureGpuFanValueRaw"):GetValue(), GpuInfoTable.GpuFanRpmCap,
            GpuInfoTable.GpuFanBarSize,
            false) ..
        ",[MeterGpuFanBarShape2H:] | Fill Color 44,130,190,255 | StrokeWidth 0")

    -- GPU 功率仪表盘
    SKIN:Bang("!SetOption", "MeterGpuPowerBar", "Shape2",
        "Rectangle [MeterGpuPowerBarShape2X:],[MeterGpuPowerBarShape2Y:]," ..
        CalcBarSize(SKIN:GetMeasure("MeasureGpuPowerValueRaw"):GetValue(), GpuInfoTable.GpuPowerCap,
            GpuInfoTable.GpuPowerBarSize,
            false) ..
        ",[MeterGpuPowerBarShape2H:] | Fill Color 44,130,190,255 | StrokeWidth 0")

    -- RAM 使用率仪表盘
    SKIN:Bang("!SetOption", "MeterRamLoadBar", "Shape2",
        "Rectangle [MeterRamLoadBarShape2X:],[MeterRamLoadBarShape2Y:],[MeterRamLoadBarShape2W:]," ..
        CalcBarSize(SKIN:GetMeasure("MeasureMemoryLoadValueRaw"):GetValue(), 100, RamInfoTable.RamLoadBarSize,
            true) .. " | Fill Color 219,236,248,255 | StrokeWidth 0")

    -- RAM 使用率添加导零
    SKIN:Bang("!SetVariable", "RamLoad", AddLeadingZeros(SKIN:GetMeasure("MeasureMemoryLoadValueRaw"):GetValue(), 2, 0))

    -- RAM 已用空间和可用空间
    SKIN:Bang("!SetVariable", "RamUsed",
        string.format("%.1f", SKIN:GetMeasure("MeasureMemoryUsedValueRaw"):GetValue() / 1024))
    SKIN:Bang("!SetVariable", "RamAvailable",
        string.format("%.1f", SKIN:GetMeasure("MeasureMemoryAvailableValueRaw"):GetValue() / 1024))

    -- 计算硬盘空间（默认每60秒更新一次）
    if os.time() > (UpTime + DiskUpTime) then
        if CpuInfoTable.CpuTempBarSize ~= 0 or CpuInfoTable.CpuTempBarSize ~= nil then
            UpTime = os.time()
        end
        DiskInfoTable.Used = CalcDiskUsed(DiskInfoTable.Drive)
        DiskInfoTable.Free = CalcDiskFree(DiskInfoTable.Drive)
        DiskInfoTable.Usage = CheckNaN(CalcPercent(DiskInfoTable.Capacity, DiskInfoTable.Used))
        -- 硬盘使用率
        SKIN:Bang("!SetVariable", "DiskUsage", DiskInfoTable.Usage)
        -- 硬盘已用空间
        SKIN:Bang("!SetVariable", "DiskUsed", UnitConvert(DiskInfoTable.Used))
        -- 硬盘可用空间
        SKIN:Bang("!SetVariable", "DiskFree", UnitConvert(DiskInfoTable.Free))
        -- 硬盘使用率仪表盘
        SKIN:Bang("!SetOption", "MeterDiskUsageBar", "Shape2",
            "Rectangle [MeterDiskUsageBarShape2X:],[MeterDiskUsageBarShape2Y:]," ..
            CalcBarSize(DiskInfoTable.Usage, 100, DiskInfoTable.UsageBarSize,
                false) ..
            ",[MeterDiskUsageBarShape2H:] | Fill Color 44,130,190,255 | StrokeWidth 0")
        -- 硬盘可用空间仪表盘
        SKIN:Bang("!SetOption", "MeterDiskFreeBar", "Shape2",
            "Rectangle [MeterDiskFreeBarShape2X:],[MeterDiskFreeBarShape2Y:]," ..
            CalcBarSize(DiskInfoTable.Free, DiskInfoTable.Capacity, DiskInfoTable.FreeBarSize,
                false) ..
            ",[MeterDiskFreeBarShape2H:] | Fill Color 44,130,190,255 | StrokeWidth 0")
    end

    -- 硬盘温度添加导零
    SKIN:Bang("!SetVariable", "DiskTemp", AddLeadingZeros(SKIN:GetMeasure("MeasureDiskTempValueRaw"):GetValue(), 2, 0))

    -- 硬盘温度仪表盘
    SKIN:Bang("!SetOption", "MeterDiskTempBar", "Shape2",
        "Rectangle [MeterDiskTempBarShape2X:],[MeterDiskTempBarShape2Y:]," ..
        CalcBarSize(SKIN:GetMeasure("MeasureDiskTempValueRaw"):GetValue(), DiskInfoTable.DiskTempCap,
            DiskInfoTable.TempBarSize,
            false) ..
        ",[MeterDiskTempBarShape2H:] | Fill Color 44,130,190,255 | StrokeWidth 0")

    -- 主板VRM温度添加导零
    SKIN:Bang("!SetVariable", "MoboVrmTemp",
        AddLeadingZeros(SKIN:GetMeasure("MeasureMoboVrmTempValueRaw"):GetValue(), 2, 0))

    -- 网络上行速率
    SKIN:Bang("!SetVariable", "NetUPRate", NetUnitConvert(SKIN:GetMeasure("MeasureNetUPRateValueRaw"):GetValue()))

    -- 网络下行速率
    SKIN:Bang("!SetVariable", "NetDLRate", NetUnitConvert(SKIN:GetMeasure("MeasureNetDLRateValueRaw"):GetValue()))
end

-- 向数字添加导零符
function AddLeadingZeros(number, minIntegerDigits, decimalPlaces)
    local integerPart = tostring(math.floor(number))
    while #integerPart < minIntegerDigits do
        integerPart = "0" .. integerPart
    end
    local decimalPart = ""
    if decimalPlaces > 0 then
        local numberStr = tostring(number)
        local dotPos = numberStr:find("%.")
        if dotPos then
            decimalPart = numberStr:sub(dotPos + 1)
            decimalPart = string.sub(decimalPart, 1, decimalPlaces) .. string.rep("0", decimalPlaces - #decimalPart)
        else
            decimalPart = string.rep("0", decimalPlaces)
        end
    end
    return integerPart .. (decimalPlaces > 0 and "." or "") .. decimalPart
end

-- 计算仪表盘尺寸
function CalcBarSize(NumCalc, TotalRng, RefSize, Invert)
    if NumCalc >= TotalRng then
        NumCalc = TotalRng
    end
    local Proportion = NumCalc / TotalRng
    local Size
    if Invert ~= false then
        Size = RefSize - (RefSize * Proportion)
    else
        Size = RefSize * Proportion
    end
    return Size
end

-- 计算最小值和最大值
function CalcMinMax(MeasureName, MinVarName, MaxVarName, Table, TableKeyMin, TableKeyMax)
    local MeasureValue = SKIN:GetMeasure(MeasureName):GetValue()
    if Table[TableKeyMin] == 0 and Table[TableKeyMax] == 0 then
        Table[TableKeyMin] = MeasureValue
        Table[TableKeyMax] = MeasureValue
    elseif MeasureValue < Table[TableKeyMin] then
        Table[TableKeyMin] = MeasureValue
    elseif MeasureValue > Table[TableKeyMax] then
        Table[TableKeyMax] = MeasureValue
    end
    SKIN:Bang("!SetVariable", MinVarName, AddLeadingZeros(Table[TableKeyMin], 2, 0))
    SKIN:Bang("!SetVariable", MaxVarName, AddLeadingZeros(Table[TableKeyMax], 2, 0))
end

-- 控制直方图
function ControlHist(MeasureName, MeterName, Table, TableArrKey, Size)
    local MeasureValue = SKIN:GetMeasure(MeasureName):GetValue()
    Table[TableArrKey][1] = CalcBarSize(MeasureValue, 100, Size, true)

    for i = 31, 1, -1 do
        local ShapeIndex = (32 - i) * 2
        local ShapeId = "Shape" .. ShapeIndex
        local Command = "Rectangle [" ..
            MeterName ..
            ShapeId ..
            "X:],[" ..
            MeterName ..
            ShapeId ..
            "Y:],[" .. MeterName ..
            ShapeId .. "W:]," .. Table[TableArrKey][i] .. " | Fill Color 255,255,255,255 | StrokeWidth 0"
        SKIN:Bang("!SetOption", MeterName, ShapeId, Command)
    end

    for i = #Table[TableArrKey], 2, -1 do
        Table[TableArrKey][i], Table[TableArrKey][i - 1] = Table[TableArrKey][i - 1], Table[TableArrKey][i]
    end
end

-- 新建指定元素数量和默认值的数组
function NewArr(Size, DefaultValue)
    local arr = {}
    for i = 1, Size do
        arr[i] = DefaultValue
    end
    return arr
end

-- 分割字符串并转换为大写
function Split(input, delimiter)
    input = tostring(input)
    delimiter = tostring(delimiter)
    if (delimiter == "") then
        return false
    end
    local pos, arr = 0, {}
    for st, sp in function()
        return string.find(input, delimiter, pos, true)
    end do
        local segment = string.sub(input, pos, st - 1)
        table.insert(arr, string.upper(segment))
        pos = sp + 1
    end
    local lastSegment = string.sub(input, pos)
    table.insert(arr, string.upper(lastSegment))
    return arr
end

-- 判断一个数是否是NAN，如果是就返回0，不是则返回原值
function CheckNaN(value)
    if value ~= value then
        return 0
    else
        return value
    end
end

-- 计算硬盘总空间（返回 GB 单位）
function CalcDiskCapacity(Table)
    local result = 0
    for i = 1, #Table, 1 do
        result = result + SKIN:GetMeasure("MeasureDiskCapacity" .. Table[i]):GetValue()
    end
    result = math.floor(result / (1024 * 1024 * 1024))
    return result
end

-- 计算硬盘已用空间
function CalcDiskUsed(Table)
    local result = 0
    for i = 1, #Table, 1 do
        result = result + SKIN:GetMeasure("MeasureDiskUsedSpace" .. Table[i]):GetValue()
    end
    result = math.floor(result / (1024 * 1024 * 1024))
    return result
end

-- 计算硬盘可用空间
function CalcDiskFree(Table)
    local result = 0
    for i = 1, #Table, 1 do
        result = result + SKIN:GetMeasure("MeasureDiskFreeSpace" .. Table[i]):GetValue()
    end
    result = math.floor(result / (1024 * 1024 * 1024))
    return result
end

-- 计算百分比
function CalcPercent(total, part)
    local percentage = (part / total) * 100
    return math.floor(percentage)
end

-- 容量单位转换（GB 转换 TB）
function UnitConvert(capacityInGB)
    if capacityInGB < 1000 then
        return capacityInGB .. " GB"
    else
        local capacityInTB = capacityInGB / 1024
        return string.format("%.1f", capacityInTB) .. " TB"
    end
end

-- 网络速率转换单位
function NetUnitConvert(Rate)
    local Units = {
        "KB/s",
        "MB/s",
        "GB/s",
        "TB/s"
    }
    local UnitsIndex = 1
    while Rate >= 1024 do
        Rate = Rate / 1024
        UnitsIndex = UnitsIndex + 1
        if UnitsIndex > #Units then
            break
        end
    end
    return string.format("%.2f%s", Rate, " " .. Units[UnitsIndex])
end
