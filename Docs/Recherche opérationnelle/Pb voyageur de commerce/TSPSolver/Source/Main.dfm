object TSPSolverForm: TTSPSolverForm
  Left = 106
  Top = 127
  ActiveControl = NumberSpinEdit
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'TSP Solver'
  ClientHeight = 462
  ClientWidth = 821
  Color = clBtnFace
  Font.Charset = GREEK_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object Label1: TLabel
    Left = 13
    Top = 176
    Width = 121
    Height = 16
    Alignment = taCenter
    AutoSize = False
    Caption = 'Number of vertices :'
  end
  object LimitLabel: TLabel
    Left = 13
    Top = 192
    Width = 121
    Height = 16
    Alignment = taCenter
    AutoSize = False
    Caption = '(4-200)'
  end
  object AlgoGroup: TRadioGroup
    Left = 5
    Top = 0
    Width = 137
    Height = 129
    Caption = 'Algorithm'
    ItemIndex = 1
    Items.Strings = (
      '&Exhaustive'
      '&Heuristic')
    TabOrder = 4
  end
  object NumberSpinEdit: TSpinEdit
    Left = 13
    Top = 216
    Width = 121
    Height = 26
    EditorEnabled = False
    MaxLength = 3
    MaxValue = 200
    MinValue = 4
    TabOrder = 0
    Value = 4
    OnChange = NumberSpinEditChange
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 443
    Width = 821
    Height = 19
    Panels = <
      item
        Alignment = taCenter
        Text = 'Created by GrMikeD - CEID - 2000'
        Width = 336
      end
      item
        Alignment = taCenter
        Width = 200
      end>
    ParentFont = True
    SimplePanel = False
    UseSystemFont = False
  end
  object ResultBox: TGroupBox
    Left = 149
    Top = 0
    Width = 185
    Height = 156
    TabOrder = 6
    object AlgoLabel: TLabel
      Left = 8
      Top = 24
      Width = 169
      Height = 16
      Alignment = taCenter
      AutoSize = False
      Caption = 'Welcome'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
    end
    object DiscLabel: TLabel
      Left = 8
      Top = 48
      Width = 169
      Height = 16
      Alignment = taCenter
      AutoSize = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
    end
    object Bevel: TBevel
      Left = 8
      Top = 72
      Width = 169
      Height = 10
      Shape = bsBottomLine
    end
    object Label2: TLabel
      Left = 8
      Top = 95
      Width = 41
      Height = 18
      Alignment = taCenter
      AutoSize = False
      Caption = 'flop:'
    end
    object Label3: TLabel
      Left = 8
      Top = 123
      Width = 41
      Height = 17
      Alignment = taCenter
      AutoSize = False
      Caption = 'time:'
    end
    object FlopEdit: TEdit
      Left = 56
      Top = 92
      Width = 116
      Height = 24
      ReadOnly = True
      TabOrder = 0
      Text = '0'
    end
    object TimeEdit: TEdit
      Left = 56
      Top = 120
      Width = 116
      Height = 24
      ReadOnly = True
      TabOrder = 1
      Text = '0 sec'
    end
  end
  object SameGraphCheckBox: TCheckBox
    Left = 26
    Top = 136
    Width = 97
    Height = 17
    Caption = '&Same Graph'
    Enabled = False
    TabOrder = 5
    OnClick = SameGraphCheckBoxClick
  end
  object Panel: TPanel
    Left = 5
    Top = 260
    Width = 329
    Height = 181
    TabOrder = 7
    object Image: TImage
      Left = 72
      Top = 100
      Width = 190
      Height = 71
      AutoSize = True
      Center = True
      Picture.Data = {
        0A544A504547496D6167652A0E0000FFD8FFE000104A46494600010100000100
        010000FFDB004300100B0C0E0C0A100E0D0E1211101318281A18161618312325
        1D283A333D3C3933383740485C4E404457453738506D51575F626768673E4D71
        797064785C656763FFDB0043011112121815182F1A1A2F634238426363636363
        6363636363636363636363636363636363636363636363636363636363636363
        63636363636363636363636363FFC0001108004700BE03012200021101031101
        FFC4001F0000010501010101010100000000000000000102030405060708090A
        0BFFC400B5100002010303020403050504040000017D01020300041105122131
        410613516107227114328191A1082342B1C11552D1F02433627282090A161718
        191A25262728292A3435363738393A434445464748494A535455565758595A63
        6465666768696A737475767778797A838485868788898A92939495969798999A
        A2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6
        D7D8D9DAE1E2E3E4E5E6E7E8E9EAF1F2F3F4F5F6F7F8F9FAFFC4001F01000301
        01010101010101010000000000000102030405060708090A0BFFC400B5110002
        0102040403040705040400010277000102031104052131061241510761711322
        328108144291A1B1C109233352F0156272D10A162434E125F11718191A262728
        292A35363738393A434445464748494A535455565758595A636465666768696A
        737475767778797A82838485868788898A92939495969798999AA2A3A4A5A6A7
        A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE2E3
        E4E5E6E7E8E9EAF2F3F4F5F6F7F8F9FAFFDA000C03010002110311003F00C3B7
        8EC2D3C3D6D79736826691CA120739CB7F8548D6361AA68D3DE5A5BB40F0EEC7
        B90338F7CD5986FA5D2FC1561731471C8CD332624048C65CF623D2A82F8A6EE7
        9EDD27114302CA8D2794A72541048E49E3E95B732B5998F2BBDD77208FC2FA93
        C024C44AC46446CD86FE58FD6AA5C68F776F63F6B954040E51973F329CE39FF3
        DC575975A25E5DF892DF52B7991ECFE471207E15463207B1E7DB934EB69AD359
        D4F55D3010D0C815D5D3B9014139FA85C7D2A7950D4A472377A45D5A58C57928
        5F2A5C63079191919A74DA25EC525B445034B70095453C8C63AFA75AECD24835
        9D4351D2A5DA638190A81D4E08DC3F0231F8D51B7D46DE4F1B4EB2C8AA82336F
        193C0DC08247E7BBF4A39623E6918571E19BFB6B692790C3B6352CC031CE3F2A
        597C2DA8C71B3FEE9F68CED56393FA56EEB5A5B25A5E4C746B718566F3D6E327
        FDEC62AA78BAEEE34DD791EDA4F2DDAD4293B41C82CDEBF4A1A8A04E4CC6B0D0
        2FAFE01344AAB19E8CE719FA549FF08DEA06ECDBAAA12AA199F77CA339C7F2AE
        A6CE38B52F0F597916B0DF7948A8F1BCBB36305C1EC7FC9A69B233585EE93043
        0D85E3E245884B90CA71939C77C107FF00AF472A17348C5BDD1458787A479E34
        372AC3E75C9E0B0FE95876112CF7F6F0BF2B24AAA47B138AEAAFB4C9F4CF04CB
        0DC80241203F29C8C1615CB5A437211EF6053B2D59199FFB849F97F5A8AAD5B4
        D0BA7E7A9B2F16851DF9B36B6B9F3449E5E41E339C7F7AAAEB71E996CD25B5AC
        332DCC6F8666395C7E75D45B4325C85D43FE11A63784070C6555527B1E4FF4AE
        3F5682EE3D527FB7C623B866DECA0838CF3DABCDC34FDA4EDCCF4F3BEBF2E875
        549AB6897DC6785269DB0D598E1CD69D868D35E1C8F923EEEDD3FF00AF5E924D
        E88E731521791C222B33138000C935BB1F846ECC48669E08257E444EDCE3DF15
        BD69610D8262D53F79DE66EA7E9E953883CC3F38DC7B93C9ADE3497521C9F439
        497C2DA847D04527FBAFFE3551F44D423EB6AE7E9CFF002AED9AD57F8415F71C
        537C93FC32BE7D339ABF65017333827B2B88FEFC122E3D548A85918750457A11
        5B85E9F37D5698F1973FBF484AFA75A5EC22F661CECF3EA2BB0BBD32DAF23961
        8A18E39F198D946037B5722CA518AB0C329C107B1AC270E4762D3B9DA4BE1CD0
        ADDCC373A8C31CCB8DCAD2E083597E22F0FC5A6C11DCDB49E64320041072083D
        08AEB7502E5ACA680CC6F5E1704456EB2E532B927732E3076E0E7BD6678C9521
        D06CE140CAA91C6A164FBCA001C1C77F5A819C2891C2140C421EAB9E0D36ACAE
        9D7AC8ACB6770CAC3729111208F514A74EBE1D6CAE3FEFD37F850055A29F2452
        42DB654646F461834CA0028A5552CC154124F402AC8D36F88C8B2B83FF006C9B
        FC2802AD153CB65750A1796DA68D475668C8144369733A1786DE59141C164424
        0FCA8020AE87C3623B8D3F52B069A38E4B8F28A798700ED6248AC0656462AC0A
        B03820F6A6D67569FB48F2DEDB7E0EE38BB33BBD62DB57BCD4E59ACF57582DDB
        6848C5C3AE3819E00C75CD73D776977FDA2D15C4DF6A9F032E1CBE78F535462D
        3AF5955D6D272AC0156111C1FA5695959DF432075B6B8561DFCB35950A0E9595
        F4F42A724F646BE9BA3C4987B8C3B7641D3F1ADE5B72D8C2E00E80700550D3A6
        9D9D639A228C7BE315D25BC2A1724F18E49AEF524968656EE66F93F2F38FE748
        9085CFDE3F415ADE5C2EC551D1980C901B271443029639ED4B9F4B872EB632BC
        BF4504FA1E69A627DB85E0FA015B0CB0B3AAAC8858E70030C9A511C718CBB2A8
        3EA714D54D2E1CBA98C6D5F1F31CFD6896DF6A63A71DAB5C88A488B44EAEBD32
        A722A95D0E2AE9546F7267148E6E556521861581C823B1AC3F125BC6C63BE8FE
        569495953D1877FC6BAB745DCD9507D2B98F1246D1AC7B8E0962700D2A8868EA
        35511F95601AD92493611E6C970F0AA02CABFC1EE475F4ACFF0016B89BC35612
        AAEC5786260B9270081C64F27EA6B4B5692D3ED56E2EEFEE60B7BA462C0C9184
        4031C052873938E33EF59FE352BFD8D6DE513245B136CA483B9703078C75AE72
        CB96924B1785D2E55437916A8C063B0519FD33F9561AF8B939DD0BB0238185C6
        6B5ADEFD22F0749137DE6B32838F58FF00FD7F9D79ED024EE77F697365AFDA98
        C440B63E7423A1E7FA77AE3AF34F7875216B102C646023CF7C9C0FD78ADAF01C
        9B354BA5FEF5B9DA3FDADCA07F3356FCA55F1469F23207DCF2EDF52403B7F5A0
        2E6ADB5859F87EC0B9014AC61A698F53FF00EBCF02B1A6F1844C711432850A00
        C819DDEBD6B77C44B15FC4B60662A19B73B271BC8EDF41FD2B9F5F0CD8B16026
        9F2B8CFCC38CF4FE1A7661CC8CED4F5DFED0B678995B2C06090001C83DBE95B5
        E1028DE1FBD8DBEF6F765FC1578FF3E958DA9E9565696AF2412C8EE00201208E
        A07A56AF8410BE8F763B12FCFBED5C7EB8A2C17395BE20DFDC11D0CAD8FCCD41
        53DE63ED93E3A798D8FCEA0A433D1AD2F3ECDA05B4AD199163810B01E81467F1
        AAB6FE2681A5C98E529D8155CFF3F4A4B66924F0FA4316DDCF6E1307A7298AA1
        6DE1FB9564DD34183DC6E38FD29D8573B1B0B982FED8CB082B86230460FE3578
        716EFB7FBA71F91ACCD26CC58DB18D5FCC663B89C63DAB494936EFD3383FD684
        050B24316B9247FDDB73FF00A10FE95A9170E7EB58525E3C1A93CF1052CE8010
        E3800E0FF4A58FC444919FB393E80114EDA0AE85B6943EB5663F8B0FBBFEF938
        AD5BE8D5D1377401BFA560E9923C9AEDBB6D1B70E73E9F29AD2D726963481625
        2C5B7640FC28B05C4D188FB0CDB7A79E71F92D3EE0FCA6AA786D8FF663AB6DE2
        7238E47DD5AB373900D6B4B726466CFC3657AD725E26CFDAE23CF29FD6BAD9DB
        806B97F1501E65B30EE187F2AD2AFC211DCEAB55748ACEC649F0D6E5197CBFB5
        8B73BCE30D9C8CE067E99E959FE34DEBA1DAA4EFE64C238C3C8390CD81939F73
        5AD3C466BC5B98755B78916331A46D6A1F6AB633CEE19E9585E2F9ADE1D1AD2C
        63984AD0C691EEE9BB680338EDD2B90D08ED732E84F1A64BFD94850BC9CECC71
        F5E9F8D7286CAE81C1B6981FF70D5B83569605411823600073E9F854B36BD2CA
        C18C401EE41EBFA568F95F5335CCBA1B3E16B37D3965BBB94292B80B12F7E083
        CFA738E3DAA8EA1AA84D7EDA489C04B7017763A123E63FA9355E7F114F25BAC7
        144B1B824993393C8038F4E958C492727926A5B5B21A4DEACED35F860BEB5904
        2DF3C5B44433D877FC7FAFB5725F61BADDB45BCA4F4E149A9AD75296DC0561E6
        2818009C102A71AD387CF95C67A67FFAD55EEB17BCB433DEDE68C12F13A81D49
        522BA5F0C5DA47A3DDC191B99F9FA32E3F98AC4BAD44DCC6C863DBBBBE7DF355
        609DE07DD19C7623B1A9D131EAD17751D3EE16E4C890B3249F302A33CF7E9EF5
        4DAD6E1412D048A00C92508C5697F6EB7D956230E5D4921CBFAE3B63DAA29357
        6785A31101B90AB73D73F8536A3DC1397636A3B930E8B1EC5258420823B617AD
        51B5D4EF323F7C7AE7A0ACFF00B7B3DB8876614285EBED8A96D4F22949F608AE
        E75FA5DF5CCF2A249292BC9C00075FA574ACE22B29642321119B1EB806B94D0E
        37322C9B7E5F5ED5D5984DC58CB0AB63CC429BBAE3208CD35F08CCBD1EF5E7D5
        8AAC5E4C26D8BA81CE7E651D7BF4ADF89CB139EC4564E99A5BE9EC85EEFCF548
        DD10797B71B8A9F53DC7EB5A30B80CD9EE453959A6285D6E72DA2CB9D6ED915D
        547CF95F5F94F4AD0F13B4A12D56262376FCE39FEED269FE1D363A9C578D7DE6
        F97BBE4F2B6E7208EB9F7AB7AC69ADAA47084BC36E23DD9C26EDD9C7B8F4A775
        7B9367CB628785815D2A40D9C8B93FFA0AD5EBA39A6693A6FF0065D99B612998
        994C85B66DC6401EA7D29D708ED9C01554B76396C8CDB923815CCF89C02901F4
        247F2AE9E685C81C735CE78A6364B4B72C3037919FC2B4ABF0B147739B17138E
        9349FF007D1A633B39CBB163EA4E68A2B90D46D1451400514514005145140051
        45140051451400E43CD6CD95CD9459CC0EE4E3EF11C514534EC06FDB6B10F1FB
        B71F9569C3AC47B7857A28AA7364D897FB662F47FCA9A9ACC193F7FF002A28A1
        5461624FED783FBCFF009539758B703EF1FC8D14535518AC2B6B36E47DF38FF7
        4D567D5ED01CF987FEF93FE145154AB35D0968ACDAAD90258C9FF8E9FF000AE7
        BC4FA95ADE45143039768DC962571DA8A2AAA4B9B51C11FFD9}
    end
    object Label5: TLabel
      Left = 16
      Top = 72
      Width = 41
      Height = 16
      Caption = 'E-Mail:'
    end
    object Label4: TLabel
      Left = 16
      Top = 48
      Width = 65
      Height = 16
      Caption = 'Web Page:'
    end
    object EmailLabel: TLabel
      Left = 88
      Top = 72
      Width = 107
      Height = 16
      Cursor = crHandPoint
      Caption = 'GrMikeD@usa.net'
      Color = clBtnFace
      Font.Charset = GREEK_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsUnderline]
      ParentColor = False
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      OnClick = EmailLabelClick
    end
    object WebSiteLabel: TLabel
      Left = 88
      Top = 48
      Width = 231
      Height = 16
      Cursor = crHandPoint
      Caption = 'http://students.ceid.upatras.gr/~miatidis'
      Font.Charset = GREEK_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsUnderline]
      ParentFont = False
      ParentShowHint = False
      ShowHint = False
      OnClick = EmailLabelClick
    end
    object TitleLabel: TLabel
      Left = 16
      Top = 16
      Width = 305
      Height = 16
      Alignment = taCenter
      AutoSize = False
      Caption = 'TSP Solver - v 1.2'
      Font.Charset = GREEK_CHARSET
      Font.Color = clMaroon
      Font.Height = -15
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
    end
  end
  object PageControl: TPageControl
    Left = 339
    Top = 8
    Width = 480
    Height = 433
    ActivePage = FlopSheet
    HotTrack = True
    TabOrder = 8
    object GraphSheet: TTabSheet
      Caption = 'Graph'
      object Label6: TLabel
        Left = 8
        Top = 347
        Width = 78
        Height = 16
        Caption = 'Optimal Tour:'
      end
      object Label7: TLabel
        Left = 56
        Top = 377
        Width = 31
        Height = 16
        Caption = 'Cost:'
      end
      object CostEdit: TEdit
        Left = 104
        Top = 374
        Width = 137
        Height = 24
        ReadOnly = True
        TabOrder = 2
      end
      object TourEdit: TEdit
        Left = 104
        Top = 344
        Width = 361
        Height = 24
        ReadOnly = True
        TabOrder = 1
      end
      object GraphGrid: TStringGrid
        Left = 0
        Top = 0
        Width = 472
        Height = 337
        Align = alTop
        DefaultColWidth = 30
        DefaultRowHeight = 20
        Font.Charset = GREEK_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = []
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goThumbTracking]
        ParentFont = False
        TabOrder = 0
        RowHeights = (
          20
          20
          20
          20
          20)
      end
    end
    object ResultsSheet: TTabSheet
      Caption = 'Results'
      ImageIndex = 1
      object Label8: TLabel
        Left = 0
        Top = 6
        Width = 233
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = 'EXHAUSTIVE'
      end
      object Label9: TLabel
        Left = 240
        Top = 6
        Width = 233
        Height = 13
        Alignment = taCenter
        AutoSize = False
        Caption = 'HEURISTIC'
      end
      object ExhaustiveView: TListView
        Left = 0
        Top = 24
        Width = 233
        Height = 344
        Columns = <
          item
            Caption = 'N'
            Width = 40
          end
          item
            Alignment = taRightJustify
            AutoSize = True
            Caption = 'flop'
          end
          item
            Alignment = taRightJustify
            Caption = 'time(sec)'
            Width = 67
          end
          item
            Alignment = taRightJustify
            AutoSize = True
            Caption = 'cost'
          end>
        SortType = stText
        TabOrder = 0
        ViewStyle = vsReport
        OnInsert = ExhaustiveViewInsert
      end
      object HeuristicView: TListView
        Left = 240
        Top = 24
        Width = 233
        Height = 344
        Columns = <
          item
            Caption = 'N'
            Width = 40
          end
          item
            Alignment = taRightJustify
            AutoSize = True
            Caption = 'flop'
          end
          item
            Alignment = taRightJustify
            Caption = 'time(sec)'
            Width = 67
          end
          item
            Alignment = taRightJustify
            AutoSize = True
            Caption = 'cost'
          end>
        SortType = stText
        TabOrder = 1
        ViewStyle = vsReport
        OnInsert = HeuristicViewInsert
      end
      object ResetExhaustiveButton: TBitBtn
        Left = 0
        Top = 371
        Width = 233
        Height = 25
        Caption = '&Reset'
        Enabled = False
        TabOrder = 2
        OnClick = ResetExhaustiveButtonClick
        Kind = bkRetry
      end
      object ResetHeuristicButton: TBitBtn
        Left = 240
        Top = 371
        Width = 233
        Height = 25
        Caption = '&Reset'
        Enabled = False
        TabOrder = 3
        OnClick = ResetExhaustiveButtonClick
        Kind = bkRetry
      end
    end
    object FlopSheet: TTabSheet
      Caption = 'Graphic (flop - N)'
      ImageIndex = 2
      object FlopChart: TChart
        Left = 0
        Top = 0
        Width = 472
        Height = 369
        BackWall.Brush.Color = clWhite
        BackWall.Brush.Style = bsClear
        Gradient.EndColor = clWhite
        Gradient.StartColor = 8421440
        Gradient.Visible = True
        LeftWall.Brush.Color = clWhite
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clMaroon
        Title.Font.Height = -12
        Title.Font.Name = 'Arial'
        Title.Font.Style = [fsBold]
        Title.Text.Strings = (
          'flop - N')
        BottomAxis.Title.Caption = 'N'
        Chart3DPercent = 10
        LeftAxis.ExactDateTime = False
        LeftAxis.Logarithmic = True
        LeftAxis.Title.Caption = 'flop'
        Legend.TextStyle = ltsPlain
        View3D = False
        Align = alTop
        BorderStyle = bsSingle
        TabOrder = 0
        object ExhaustiveFlopPoint: TPointSeries
          Marks.ArrowLength = 0
          Marks.Visible = False
          SeriesColor = clRed
          Title = 'Exhaustive'
          Pointer.InflateMargins = True
          Pointer.Style = psCross
          Pointer.Visible = True
          XValues.DateTime = False
          XValues.Name = 'X'
          XValues.Multiplier = 1
          XValues.Order = loAscending
          YValues.DateTime = False
          YValues.Name = 'Y'
          YValues.Multiplier = 1
          YValues.Order = loNone
        end
        object HeuristicFlopPoint: TPointSeries
          Marks.ArrowLength = 0
          Marks.Visible = False
          SeriesColor = clBlue
          Title = 'Heuristic'
          Pointer.Brush.Color = clBlue
          Pointer.InflateMargins = True
          Pointer.Style = psDiagCross
          Pointer.Visible = True
          XValues.DateTime = False
          XValues.Name = 'X'
          XValues.Multiplier = 1
          XValues.Order = loAscending
          YValues.DateTime = False
          YValues.Name = 'Y'
          YValues.Multiplier = 1
          YValues.Order = loNone
        end
        object ExhaustiveFlopLine: TLineSeries
          Marks.ArrowLength = 8
          Marks.Visible = False
          DataSource = ExhaustiveFlopPoint
          SeriesColor = clRed
          ShowInLegend = False
          Title = 'ExhaustiveLine'
          Pointer.InflateMargins = True
          Pointer.Style = psCircle
          Pointer.Visible = False
          XValues.DateTime = False
          XValues.Name = 'X'
          XValues.Multiplier = 1
          XValues.Order = loAscending
          YValues.DateTime = False
          YValues.Name = 'Y'
          YValues.Multiplier = 1
          YValues.Order = loNone
        end
        object HeuristicFlopLine: TLineSeries
          Marks.ArrowLength = 8
          Marks.Visible = False
          DataSource = HeuristicFlopPoint
          SeriesColor = clBlue
          ShowInLegend = False
          Title = 'HeuristicLine'
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.DateTime = False
          XValues.Name = 'X'
          XValues.Multiplier = 1
          XValues.Order = loAscending
          YValues.DateTime = False
          YValues.Name = 'Y'
          YValues.Multiplier = 1
          YValues.Order = loNone
        end
      end
      object Log1CheckBox: TCheckBox
        Left = 8
        Top = 379
        Width = 89
        Height = 17
        Caption = '&Logarithmic'
        Checked = True
        State = cbChecked
        TabOrder = 1
        OnClick = Log1CheckBoxClick
      end
      object CopyButton1: TBitBtn
        Left = 216
        Top = 373
        Width = 115
        Height = 28
        Caption = '&Copy'
        TabOrder = 2
        OnClick = CopyButton1Click
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF003333330B7FFF
          FFB0333333777F3333773333330B7FFFFFB0333333777F3333773333330B7FFF
          FFB0333333777F3333773333330B7FFFFFB03FFFFF777FFFFF77000000000077
          007077777777777777770FFFFFFFF00077B07F33333337FFFF770FFFFFFFF000
          7BB07F3FF3FFF77FF7770F00F000F00090077F77377737777F770FFFFFFFF039
          99337F3FFFF3F7F777FF0F0000F0F09999937F7777373777777F0FFFFFFFF999
          99997F3FF3FFF77777770F00F000003999337F773777773777F30FFFF0FF0339
          99337F3FF7F3733777F30F08F0F0337999337F7737F73F7777330FFFF0039999
          93337FFFF7737777733300000033333333337777773333333333}
        NumGlyphs = 2
      end
      object SaveButton1: TBitBtn
        Left = 349
        Top = 373
        Width = 115
        Height = 28
        Caption = '&Save as...'
        TabOrder = 3
        OnClick = SaveButton1Click
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333330070
          7700333333337777777733333333008088003333333377F73377333333330088
          88003333333377FFFF7733333333000000003FFFFFFF77777777000000000000
          000077777777777777770FFFFFFF0FFFFFF07F3333337F3333370FFFFFFF0FFF
          FFF07F3FF3FF7FFFFFF70F00F0080CCC9CC07F773773777777770FFFFFFFF039
          99337F3FFFF3F7F777F30F0000F0F09999937F7777373777777F0FFFFFFFF999
          99997F3FF3FFF77777770F00F000003999337F773777773777F30FFFF0FF0339
          99337F3FF7F3733777F30F08F0F0337999337F7737F73F7777330FFFF0039999
          93337FFFF7737777733300000033333333337777773333333333}
        NumGlyphs = 2
      end
    end
    object TimeSheet: TTabSheet
      Caption = 'Graphic (time - N)'
      ImageIndex = 3
      object TimeChart: TChart
        Left = 0
        Top = 0
        Width = 472
        Height = 369
        BackWall.Brush.Color = clWhite
        BackWall.Brush.Style = bsClear
        Gradient.EndColor = clWhite
        Gradient.StartColor = 8421440
        Gradient.Visible = True
        Title.Brush.Color = clWhite
        Title.Brush.Style = bsClear
        Title.Color = clWhite
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clMaroon
        Title.Font.Height = -12
        Title.Font.Name = 'Arial'
        Title.Font.Style = [fsBold]
        Title.Text.Strings = (
          'time - N')
        BottomAxis.Title.Caption = 'N'
        Chart3DPercent = 10
        LeftAxis.ExactDateTime = False
        LeftAxis.Logarithmic = True
        LeftAxis.Title.Caption = 'time(sec)'
        View3D = False
        Align = alTop
        BorderStyle = bsSingle
        TabOrder = 0
        object ExhaustiveTimePoint: TPointSeries
          Marks.ArrowLength = 0
          Marks.Visible = False
          SeriesColor = clRed
          Title = 'Exhaustive'
          ValueFormat = '#,##0.####'
          Pointer.Brush.Color = clRed
          Pointer.InflateMargins = True
          Pointer.Style = psCross
          Pointer.Visible = True
          XValues.DateTime = False
          XValues.Name = 'X'
          XValues.Multiplier = 1
          XValues.Order = loAscending
          YValues.DateTime = False
          YValues.Name = 'Y'
          YValues.Multiplier = 1
          YValues.Order = loNone
        end
        object HeuristicTimePoint: TPointSeries
          Marks.ArrowLength = 0
          Marks.Visible = False
          SeriesColor = clBlue
          Title = 'Heuristic'
          ValueFormat = '#,##0.####'
          Pointer.Brush.Color = clBlue
          Pointer.InflateMargins = True
          Pointer.Style = psDiagCross
          Pointer.Visible = True
          XValues.DateTime = False
          XValues.Name = 'X'
          XValues.Multiplier = 1
          XValues.Order = loAscending
          YValues.DateTime = False
          YValues.Name = 'Y'
          YValues.Multiplier = 1
          YValues.Order = loNone
        end
        object ExhaustiveTimeLine: TLineSeries
          Marks.ArrowLength = 8
          Marks.Visible = False
          DataSource = ExhaustiveTimePoint
          SeriesColor = clRed
          ShowInLegend = False
          Title = 'Exhaustive'
          ValueFormat = '#,##0.####'
          Pointer.InflateMargins = True
          Pointer.Style = psCross
          Pointer.Visible = False
          XValues.DateTime = False
          XValues.Name = 'X'
          XValues.Multiplier = 1
          XValues.Order = loAscending
          YValues.DateTime = False
          YValues.Name = 'Y'
          YValues.Multiplier = 1
          YValues.Order = loNone
        end
        object HeuristicTimeLine: TLineSeries
          Marks.ArrowLength = 8
          Marks.Visible = False
          DataSource = HeuristicTimePoint
          SeriesColor = clBlue
          ShowInLegend = False
          Title = 'Heuristic'
          ValueFormat = '#,##0.####'
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          Pointer.Visible = False
          XValues.DateTime = False
          XValues.Name = 'X'
          XValues.Multiplier = 1
          XValues.Order = loAscending
          YValues.DateTime = False
          YValues.Name = 'Y'
          YValues.Multiplier = 1
          YValues.Order = loNone
        end
      end
      object Log2CheckBox: TCheckBox
        Left = 8
        Top = 379
        Width = 89
        Height = 17
        Caption = '&Logarithmic'
        Checked = True
        State = cbChecked
        TabOrder = 1
        OnClick = Log1CheckBoxClick
      end
      object CopyButton2: TBitBtn
        Left = 216
        Top = 373
        Width = 115
        Height = 28
        Caption = '&Copy'
        TabOrder = 2
        OnClick = CopyButton1Click
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF003333330B7FFF
          FFB0333333777F3333773333330B7FFFFFB0333333777F3333773333330B7FFF
          FFB0333333777F3333773333330B7FFFFFB03FFFFF777FFFFF77000000000077
          007077777777777777770FFFFFFFF00077B07F33333337FFFF770FFFFFFFF000
          7BB07F3FF3FFF77FF7770F00F000F00090077F77377737777F770FFFFFFFF039
          99337F3FFFF3F7F777FF0F0000F0F09999937F7777373777777F0FFFFFFFF999
          99997F3FF3FFF77777770F00F000003999337F773777773777F30FFFF0FF0339
          99337F3FF7F3733777F30F08F0F0337999337F7737F73F7777330FFFF0039999
          93337FFFF7737777733300000033333333337777773333333333}
        NumGlyphs = 2
      end
      object SaveButton2: TBitBtn
        Left = 349
        Top = 373
        Width = 115
        Height = 28
        Caption = '&Save as...'
        TabOrder = 3
        OnClick = SaveButton1Click
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333330070
          7700333333337777777733333333008088003333333377F73377333333330088
          88003333333377FFFF7733333333000000003FFFFFFF77777777000000000000
          000077777777777777770FFFFFFF0FFFFFF07F3333337F3333370FFFFFFF0FFF
          FFF07F3FF3FF7FFFFFF70F00F0080CCC9CC07F773773777777770FFFFFFFF039
          99337F3FFFF3F7F777F30F0000F0F09999937F7777373777777F0FFFFFFFF999
          99997F3FF3FFF77777770F00F000003999337F773777773777F30FFFF0FF0339
          99337F3FF7F3733777F30F08F0F0337999337F7737F73F7777330FFFF0039999
          93337FFFF7737777733300000033333333337777773333333333}
        NumGlyphs = 2
      end
    end
    object CostSheet: TTabSheet
      Caption = 'Graphic (cost - N)'
      ImageIndex = 4
      object CostChart: TChart
        Left = 0
        Top = 0
        Width = 472
        Height = 369
        BackWall.Brush.Color = clWhite
        BackWall.Brush.Style = bsClear
        Gradient.EndColor = clWhite
        Gradient.StartColor = 8421440
        Gradient.Visible = True
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clMaroon
        Title.Font.Height = -12
        Title.Font.Name = 'Arial'
        Title.Font.Style = [fsBold]
        Title.Text.Strings = (
          'cost - N')
        BottomAxis.Title.Caption = 'N'
        Chart3DPercent = 20
        LeftAxis.Title.Caption = 'cost'
        View3D = False
        Align = alTop
        BorderStyle = bsSingle
        TabOrder = 0
        object ExhaustiveCostBar: TBarSeries
          Marks.ArrowLength = 20
          Marks.Visible = False
          SeriesColor = clRed
          Title = 'Exhaustive'
          XValues.DateTime = False
          XValues.Name = 'X'
          XValues.Multiplier = 1
          XValues.Order = loAscending
          YValues.DateTime = False
          YValues.Name = 'Bar'
          YValues.Multiplier = 1
          YValues.Order = loNone
        end
        object HeuristicCostBar: TBarSeries
          Marks.ArrowLength = 20
          Marks.Visible = False
          SeriesColor = clBlue
          Title = 'Heuristic'
          XValues.DateTime = False
          XValues.Name = 'X'
          XValues.Multiplier = 1
          XValues.Order = loAscending
          YValues.DateTime = False
          YValues.Name = 'Bar'
          YValues.Multiplier = 1
          YValues.Order = loNone
        end
      end
      object ViewCheckBox: TCheckBox
        Left = 8
        Top = 379
        Width = 73
        Height = 17
        Caption = '3-D &View'
        TabOrder = 1
        OnClick = ViewCheckBoxClick
      end
      object CopyButton3: TBitBtn
        Left = 216
        Top = 373
        Width = 115
        Height = 28
        Caption = '&Copy'
        TabOrder = 2
        OnClick = CopyButton1Click
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF003333330B7FFF
          FFB0333333777F3333773333330B7FFFFFB0333333777F3333773333330B7FFF
          FFB0333333777F3333773333330B7FFFFFB03FFFFF777FFFFF77000000000077
          007077777777777777770FFFFFFFF00077B07F33333337FFFF770FFFFFFFF000
          7BB07F3FF3FFF77FF7770F00F000F00090077F77377737777F770FFFFFFFF039
          99337F3FFFF3F7F777FF0F0000F0F09999937F7777373777777F0FFFFFFFF999
          99997F3FF3FFF77777770F00F000003999337F773777773777F30FFFF0FF0339
          99337F3FF7F3733777F30F08F0F0337999337F7737F73F7777330FFFF0039999
          93337FFFF7737777733300000033333333337777773333333333}
        NumGlyphs = 2
      end
      object SaveButton3: TBitBtn
        Left = 349
        Top = 373
        Width = 115
        Height = 28
        Caption = '&Save as...'
        TabOrder = 3
        OnClick = SaveButton1Click
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333330070
          7700333333337777777733333333008088003333333377F73377333333330088
          88003333333377FFFF7733333333000000003FFFFFFF77777777000000000000
          000077777777777777770FFFFFFF0FFFFFF07F3333337F3333370FFFFFFF0FFF
          FFF07F3FF3FF7FFFFFF70F00F0080CCC9CC07F773773777777770FFFFFFFF039
          99337F3FFFF3F7F777F30F0000F0F09999937F7777373777777F0FFFFFFFF999
          99997F3FF3FFF77777770F00F000003999337F773777773777F30FFFF0FF0339
          99337F3FF7F3733777F30F08F0F0337999337F7737F73F7777330FFFF0039999
          93337FFFF7737777733300000033333333337777773333333333}
        NumGlyphs = 2
      end
    end
  end
  object AutoCheckBox: TCheckBox
    Left = 285
    Top = 172
    Width = 49
    Height = 18
    Caption = '&Auto'
    TabOrder = 3
    OnClick = AutoCheckBoxClick
  end
  object AddButton: TBitBtn
    Left = 149
    Top = 164
    Width = 131
    Height = 30
    Caption = '&Add to Results'
    Enabled = False
    TabOrder = 2
    OnClick = AddButtonClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333303
      333333333333337FF3333333333333903333333333333377FF33333333333399
      03333FFFFFFFFF777FF3000000999999903377777777777777FF0FFFF0999999
      99037F3337777777777F0FFFF099999999907F3FF777777777770F00F0999999
      99037F773777777777730FFFF099999990337F3FF777777777330F00FFFFF099
      03337F773333377773330FFFFFFFF09033337F3FF3FFF77733330F00F0000003
      33337F773777777333330FFFF0FF033333337F3FF7F3733333330F08F0F03333
      33337F7737F7333333330FFFF003333333337FFFF77333333333000000333333
      3333777777333333333333333333333333333333333333333333}
    NumGlyphs = 2
  end
  object StartButton: TBitBtn
    Left = 149
    Top = 208
    Width = 185
    Height = 44
    Caption = '&Start'
    TabOrder = 1
    OnClick = StartButtonClick
    Kind = bkOK
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'bmp'
    Filter = 'Bitmap Files(*.bmp)|*.bmp'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofPathMustExist]
    Left = 104
    Top = 88
  end
end
