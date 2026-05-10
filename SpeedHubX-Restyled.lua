--[[
  Speed Hub X — Restyled Edition (dark + red, rounded, mobile/desktop responsive, Lucide icons)
  Visual retheme of the original Speed Hub X library.
  API is fully preserved:
      local Lib = loadstring(...)()
      local Win = Lib:CreateWindow({"Title","Sub"})
      local Tab = Win:CreateTab({"Main", "lucide-home"})
      local Sec = Tab:AddSection("My Section", true)
      Sec:AddButton({"Click me","desc","lucide-rocket", function() end})

  Pass an icon name like "lucide-home" anywhere an image asset is expected;
  it will be auto-resolved against the embedded Lucide icon map.
]]

local UserInputService_SX = game:GetService("UserInputService")
local LucideIcons = {
  ["lucide-accessibility"] = "rbxassetid://10709751939",
  ["lucide-activity"] = "rbxassetid://10709752035",
  ["lucide-air-vent"] = "rbxassetid://10709752131",
  ["lucide-airplay"] = "rbxassetid://10709752254",
  ["lucide-alarm-check"] = "rbxassetid://10709752405",
  ["lucide-alarm-clock"] = "rbxassetid://10709752630",
  ["lucide-alarm-clock-off"] = "rbxassetid://10709752508",
  ["lucide-alarm-minus"] = "rbxassetid://10709752732",
  ["lucide-alarm-plus"] = "rbxassetid://10709752825",
  ["lucide-album"] = "rbxassetid://10709752906",
  ["lucide-alert-circle"] = "rbxassetid://10709752996",
  ["lucide-alert-octagon"] = "rbxassetid://10709753064",
  ["lucide-alert-triangle"] = "rbxassetid://10709753149",
  ["lucide-align-center"] = "rbxassetid://10709753570",
  ["lucide-align-center-horizontal"] = "rbxassetid://10709753272",
  ["lucide-align-center-vertical"] = "rbxassetid://10709753421",
  ["lucide-align-end-horizontal"] = "rbxassetid://10709753692",
  ["lucide-align-end-vertical"] = "rbxassetid://10709753808",
  ["lucide-align-horizontal-distribute-center"] = "rbxassetid://10747779791",
  ["lucide-align-horizontal-distribute-end"] = "rbxassetid://10747784534",
  ["lucide-align-horizontal-distribute-start"] = "rbxassetid://10709754118",
  ["lucide-align-horizontal-justify-center"] = "rbxassetid://10709754204",
  ["lucide-align-horizontal-justify-end"] = "rbxassetid://10709754317",
  ["lucide-align-horizontal-justify-start"] = "rbxassetid://10709754436",
  ["lucide-align-horizontal-space-around"] = "rbxassetid://10709754590",
  ["lucide-align-horizontal-space-between"] = "rbxassetid://10709754749",
  ["lucide-align-justify"] = "rbxassetid://10709759610",
  ["lucide-align-left"] = "rbxassetid://10709759764",
  ["lucide-align-right"] = "rbxassetid://10709759895",
  ["lucide-align-start-horizontal"] = "rbxassetid://10709760051",
  ["lucide-align-start-vertical"] = "rbxassetid://10709760244",
  ["lucide-align-vertical-distribute-center"] = "rbxassetid://10709760351",
  ["lucide-align-vertical-distribute-end"] = "rbxassetid://10709760434",
  ["lucide-align-vertical-distribute-start"] = "rbxassetid://10709760612",
  ["lucide-align-vertical-justify-center"] = "rbxassetid://10709760814",
  ["lucide-align-vertical-justify-end"] = "rbxassetid://10709761003",
  ["lucide-align-vertical-justify-start"] = "rbxassetid://10709761176",
  ["lucide-align-vertical-space-around"] = "rbxassetid://10709761324",
  ["lucide-align-vertical-space-between"] = "rbxassetid://10709761434",
  ["lucide-anchor"] = "rbxassetid://10709761530",
  ["lucide-angry"] = "rbxassetid://10709761629",
  ["lucide-annoyed"] = "rbxassetid://10709761722",
  ["lucide-aperture"] = "rbxassetid://10709761813",
  ["lucide-apple"] = "rbxassetid://10709761889",
  ["lucide-archive"] = "rbxassetid://10709762233",
  ["lucide-archive-restore"] = "rbxassetid://10709762058",
  ["lucide-armchair"] = "rbxassetid://10709762327",
  ["lucide-arrow-big-down"] = "rbxassetid://10747796644",
  ["lucide-arrow-big-left"] = "rbxassetid://10709762574",
  ["lucide-arrow-big-right"] = "rbxassetid://10709762727",
  ["lucide-arrow-big-up"] = "rbxassetid://10709762879",
  ["lucide-arrow-down"] = "rbxassetid://10709767827",
  ["lucide-arrow-down-circle"] = "rbxassetid://10709763034",
  ["lucide-arrow-down-left"] = "rbxassetid://10709767656",
  ["lucide-arrow-down-right"] = "rbxassetid://10709767750",
  ["lucide-arrow-left"] = "rbxassetid://10709768114",
  ["lucide-arrow-left-circle"] = "rbxassetid://10709767936",
  ["lucide-arrow-left-right"] = "rbxassetid://10709768019",
  ["lucide-arrow-right"] = "rbxassetid://10709768347",
  ["lucide-arrow-right-circle"] = "rbxassetid://10709768226",
  ["lucide-arrow-up"] = "rbxassetid://10709768939",
  ["lucide-arrow-up-circle"] = "rbxassetid://10709768432",
  ["lucide-arrow-up-down"] = "rbxassetid://10709768538",
  ["lucide-arrow-up-left"] = "rbxassetid://10709768661",
  ["lucide-arrow-up-right"] = "rbxassetid://10709768787",
  ["lucide-asterisk"] = "rbxassetid://10709769095",
  ["lucide-at-sign"] = "rbxassetid://10709769286",
  ["lucide-award"] = "rbxassetid://10709769406",
  ["lucide-axe"] = "rbxassetid://10709769508",
  ["lucide-axis-3d"] = "rbxassetid://10709769598",
  ["lucide-baby"] = "rbxassetid://10709769732",
  ["lucide-backpack"] = "rbxassetid://10709769841",
  ["lucide-baggage-claim"] = "rbxassetid://10709769935",
  ["lucide-banana"] = "rbxassetid://10709770005",
  ["lucide-banknote"] = "rbxassetid://10709770178",
  ["lucide-bar-chart"] = "rbxassetid://10709773755",
  ["lucide-bar-chart-2"] = "rbxassetid://10709770317",
  ["lucide-bar-chart-3"] = "rbxassetid://10709770431",
  ["lucide-bar-chart-4"] = "rbxassetid://10709770560",
  ["lucide-bar-chart-horizontal"] = "rbxassetid://10709773669",
  ["lucide-barcode"] = "rbxassetid://10747360675",
  ["lucide-baseline"] = "rbxassetid://10709773863",
  ["lucide-bath"] = "rbxassetid://10709773963",
  ["lucide-battery"] = "rbxassetid://10709774640",
  ["lucide-battery-charging"] = "rbxassetid://10709774068",
  ["lucide-battery-full"] = "rbxassetid://10709774206",
  ["lucide-battery-low"] = "rbxassetid://10709774370",
  ["lucide-battery-medium"] = "rbxassetid://10709774513",
  ["lucide-beaker"] = "rbxassetid://10709774756",
  ["lucide-bed"] = "rbxassetid://10709775036",
  ["lucide-bed-double"] = "rbxassetid://10709774864",
  ["lucide-bed-single"] = "rbxassetid://10709774968",
  ["lucide-beer"] = "rbxassetid://10709775167",
  ["lucide-bell"] = "rbxassetid://10709775704",
  ["lucide-bell-minus"] = "rbxassetid://10709775241",
  ["lucide-bell-off"] = "rbxassetid://10709775320",
  ["lucide-bell-plus"] = "rbxassetid://10709775448",
  ["lucide-bell-ring"] = "rbxassetid://10709775560",
  ["lucide-bike"] = "rbxassetid://10709775894",
  ["lucide-binary"] = "rbxassetid://10709776050",
  ["lucide-bitcoin"] = "rbxassetid://10709776126",
  ["lucide-bluetooth"] = "rbxassetid://10709776655",
  ["lucide-bluetooth-connected"] = "rbxassetid://10709776240",
  ["lucide-bluetooth-off"] = "rbxassetid://10709776344",
  ["lucide-bluetooth-searching"] = "rbxassetid://10709776501",
  ["lucide-bold"] = "rbxassetid://10747813908",
  ["lucide-bomb"] = "rbxassetid://10709781460",
  ["lucide-bone"] = "rbxassetid://10709781605",
  ["lucide-book"] = "rbxassetid://10709781824",
  ["lucide-book-open"] = "rbxassetid://10709781717",
  ["lucide-bookmark"] = "rbxassetid://10709782154",
  ["lucide-bookmark-minus"] = "rbxassetid://10709781919",
  ["lucide-bookmark-plus"] = "rbxassetid://10709782044",
  ["lucide-bot"] = "rbxassetid://10709782230",
  ["lucide-box"] = "rbxassetid://10709782497",
  ["lucide-box-select"] = "rbxassetid://10709782342",
  ["lucide-boxes"] = "rbxassetid://10709782582",
  ["lucide-briefcase"] = "rbxassetid://10709782662",
  ["lucide-brush"] = "rbxassetid://10709782758",
  ["lucide-bug"] = "rbxassetid://10709782845",
  ["lucide-building"] = "rbxassetid://10709783051",
  ["lucide-building-2"] = "rbxassetid://10709782939",
  ["lucide-bus"] = "rbxassetid://10709783137",
  ["lucide-cake"] = "rbxassetid://10709783217",
  ["lucide-calculator"] = "rbxassetid://10709783311",
  ["lucide-calendar"] = "rbxassetid://10709789505",
  ["lucide-calendar-check"] = "rbxassetid://10709783474",
  ["lucide-calendar-check-2"] = "rbxassetid://10709783392",
  ["lucide-calendar-clock"] = "rbxassetid://10709783577",
  ["lucide-calendar-days"] = "rbxassetid://10709783673",
  ["lucide-calendar-heart"] = "rbxassetid://10709783835",
  ["lucide-calendar-minus"] = "rbxassetid://10709783959",
  ["lucide-calendar-off"] = "rbxassetid://10709788784",
  ["lucide-calendar-plus"] = "rbxassetid://10709788937",
  ["lucide-calendar-range"] = "rbxassetid://10709789053",
  ["lucide-calendar-search"] = "rbxassetid://10709789200",
  ["lucide-calendar-x"] = "rbxassetid://10709789407",
  ["lucide-calendar-x-2"] = "rbxassetid://10709789329",
  ["lucide-camera"] = "rbxassetid://10709789686",
  ["lucide-camera-off"] = "rbxassetid://10747822677",
  ["lucide-car"] = "rbxassetid://10709789810",
  ["lucide-carrot"] = "rbxassetid://10709789960",
  ["lucide-cast"] = "rbxassetid://10709790097",
  ["lucide-charge"] = "rbxassetid://10709790202",
  ["lucide-check"] = "rbxassetid://10709790644",
  ["lucide-check-circle"] = "rbxassetid://10709790387",
  ["lucide-check-circle-2"] = "rbxassetid://10709790298",
  ["lucide-check-square"] = "rbxassetid://10709790537",
  ["lucide-chef-hat"] = "rbxassetid://10709790757",
  ["lucide-cherry"] = "rbxassetid://10709790875",
  ["lucide-chevron-down"] = "rbxassetid://10709790948",
  ["lucide-chevron-first"] = "rbxassetid://10709791015",
  ["lucide-chevron-last"] = "rbxassetid://10709791130",
  ["lucide-chevron-left"] = "rbxassetid://10709791281",
  ["lucide-chevron-right"] = "rbxassetid://10709791437",
  ["lucide-chevron-up"] = "rbxassetid://10709791523",
  ["lucide-chevrons-down"] = "rbxassetid://10709796864",
  ["lucide-chevrons-down-up"] = "rbxassetid://10709791632",
  ["lucide-chevrons-left"] = "rbxassetid://10709797151",
  ["lucide-chevrons-left-right"] = "rbxassetid://10709797006",
  ["lucide-chevrons-right"] = "rbxassetid://10709797382",
  ["lucide-chevrons-right-left"] = "rbxassetid://10709797274",
  ["lucide-chevrons-up"] = "rbxassetid://10709797622",
  ["lucide-chevrons-up-down"] = "rbxassetid://10709797508",
  ["lucide-chrome"] = "rbxassetid://10709797725",
  ["lucide-circle"] = "rbxassetid://10709798174",
  ["lucide-circle-dot"] = "rbxassetid://10709797837",
  ["lucide-circle-ellipsis"] = "rbxassetid://10709797985",
  ["lucide-circle-slashed"] = "rbxassetid://10709798100",
  ["lucide-citrus"] = "rbxassetid://10709798276",
  ["lucide-clapperboard"] = "rbxassetid://10709798350",
  ["lucide-clipboard"] = "rbxassetid://10709799288",
  ["lucide-clipboard-check"] = "rbxassetid://10709798443",
  ["lucide-clipboard-copy"] = "rbxassetid://10709798574",
  ["lucide-clipboard-edit"] = "rbxassetid://10709798682",
  ["lucide-clipboard-list"] = "rbxassetid://10709798792",
  ["lucide-clipboard-signature"] = "rbxassetid://10709798890",
  ["lucide-clipboard-type"] = "rbxassetid://10709798999",
  ["lucide-clipboard-x"] = "rbxassetid://10709799124",
  ["lucide-clock"] = "rbxassetid://10709805144",
  ["lucide-clock-1"] = "rbxassetid://10709799535",
  ["lucide-clock-10"] = "rbxassetid://10709799718",
  ["lucide-clock-11"] = "rbxassetid://10709799818",
  ["lucide-clock-12"] = "rbxassetid://10709799962",
  ["lucide-clock-2"] = "rbxassetid://10709803876",
  ["lucide-clock-3"] = "rbxassetid://10709803989",
  ["lucide-clock-4"] = "rbxassetid://10709804164",
  ["lucide-clock-5"] = "rbxassetid://10709804291",
  ["lucide-clock-6"] = "rbxassetid://10709804435",
  ["lucide-clock-7"] = "rbxassetid://10709804599",
  ["lucide-clock-8"] = "rbxassetid://10709804784",
  ["lucide-clock-9"] = "rbxassetid://10709804996",
  ["lucide-cloud"] = "rbxassetid://10709806740",
  ["lucide-cloud-cog"] = "rbxassetid://10709805262",
  ["lucide-cloud-drizzle"] = "rbxassetid://10709805371",
  ["lucide-cloud-fog"] = "rbxassetid://10709805477",
  ["lucide-cloud-hail"] = "rbxassetid://10709805596",
  ["lucide-cloud-lightning"] = "rbxassetid://10709805727",
  ["lucide-cloud-moon"] = "rbxassetid://10709805942",
  ["lucide-cloud-moon-rain"] = "rbxassetid://10709805838",
  ["lucide-cloud-off"] = "rbxassetid://10709806060",
  ["lucide-cloud-rain"] = "rbxassetid://10709806277",
  ["lucide-cloud-rain-wind"] = "rbxassetid://10709806166",
  ["lucide-cloud-snow"] = "rbxassetid://10709806374",
  ["lucide-cloud-sun"] = "rbxassetid://10709806631",
  ["lucide-cloud-sun-rain"] = "rbxassetid://10709806475",
  ["lucide-cloudy"] = "rbxassetid://10709806859",
  ["lucide-clover"] = "rbxassetid://10709806995",
  ["lucide-code"] = "rbxassetid://10709810463",
  ["lucide-code-2"] = "rbxassetid://10709807111",
  ["lucide-codepen"] = "rbxassetid://10709810534",
  ["lucide-codesandbox"] = "rbxassetid://10709810676",
  ["lucide-coffee"] = "rbxassetid://10709810814",
  ["lucide-cog"] = "rbxassetid://10709810948",
  ["lucide-coins"] = "rbxassetid://10709811110",
  ["lucide-columns"] = "rbxassetid://10709811261",
  ["lucide-command"] = "rbxassetid://10709811365",
  ["lucide-compass"] = "rbxassetid://10709811445",
  ["lucide-component"] = "rbxassetid://10709811595",
  ["lucide-concierge-bell"] = "rbxassetid://10709811706",
  ["lucide-connection"] = "rbxassetid://10747361219",
  ["lucide-contact"] = "rbxassetid://10709811834",
  ["lucide-contrast"] = "rbxassetid://10709811939",
  ["lucide-cookie"] = "rbxassetid://10709812067",
  ["lucide-copy"] = "rbxassetid://10709812159",
  ["lucide-copyleft"] = "rbxassetid://10709812251",
  ["lucide-copyright"] = "rbxassetid://10709812311",
  ["lucide-corner-down-left"] = "rbxassetid://10709812396",
  ["lucide-corner-down-right"] = "rbxassetid://10709812485",
  ["lucide-corner-left-down"] = "rbxassetid://10709812632",
  ["lucide-corner-left-up"] = "rbxassetid://10709812784",
  ["lucide-corner-right-down"] = "rbxassetid://10709812939",
  ["lucide-corner-right-up"] = "rbxassetid://10709813094",
  ["lucide-corner-up-left"] = "rbxassetid://10709813185",
  ["lucide-corner-up-right"] = "rbxassetid://10709813281",
  ["lucide-cpu"] = "rbxassetid://10709813383",
  ["lucide-croissant"] = "rbxassetid://10709818125",
  ["lucide-crop"] = "rbxassetid://10709818245",
  ["lucide-cross"] = "rbxassetid://10709818399",
  ["lucide-crosshair"] = "rbxassetid://10709818534",
  ["lucide-crown"] = "rbxassetid://10709818626",
  ["lucide-cup-soda"] = "rbxassetid://10709818763",
  ["lucide-curly-braces"] = "rbxassetid://10709818847",
  ["lucide-currency"] = "rbxassetid://10709818931",
  ["lucide-database"] = "rbxassetid://10709818996",
  ["lucide-delete"] = "rbxassetid://10709819059",
  ["lucide-diamond"] = "rbxassetid://10709819149",
  ["lucide-dice-1"] = "rbxassetid://10709819266",
  ["lucide-dice-2"] = "rbxassetid://10709819361",
  ["lucide-dice-3"] = "rbxassetid://10709819508",
  ["lucide-dice-4"] = "rbxassetid://10709819670",
  ["lucide-dice-5"] = "rbxassetid://10709819801",
  ["lucide-dice-6"] = "rbxassetid://10709819896",
  ["lucide-dices"] = "rbxassetid://10723343321",
  ["lucide-diff"] = "rbxassetid://10723343416",
  ["lucide-disc"] = "rbxassetid://10723343537",
  ["lucide-divide"] = "rbxassetid://10723343805",
  ["lucide-divide-circle"] = "rbxassetid://10723343636",
  ["lucide-divide-square"] = "rbxassetid://10723343737",
  ["lucide-dollar-sign"] = "rbxassetid://10723343958",
  ["lucide-download"] = "rbxassetid://10723344270",
  ["lucide-download-cloud"] = "rbxassetid://10723344088",
  ["lucide-droplet"] = "rbxassetid://10723344432",
  ["lucide-droplets"] = "rbxassetid://10734883356",
  ["lucide-drumstick"] = "rbxassetid://10723344737",
  ["lucide-edit"] = "rbxassetid://10734883598",
  ["lucide-edit-2"] = "rbxassetid://10723344885",
  ["lucide-edit-3"] = "rbxassetid://10723345088",
  ["lucide-egg"] = "rbxassetid://10723345518",
  ["lucide-egg-fried"] = "rbxassetid://10723345347",
  ["lucide-electricity"] = "rbxassetid://10723345749",
  ["lucide-electricity-off"] = "rbxassetid://10723345643",
  ["lucide-equal"] = "rbxassetid://10723345990",
  ["lucide-equal-not"] = "rbxassetid://10723345866",
  ["lucide-eraser"] = "rbxassetid://10723346158",
  ["lucide-euro"] = "rbxassetid://10723346372",
  ["lucide-expand"] = "rbxassetid://10723346553",
  ["lucide-external-link"] = "rbxassetid://10723346684",
  ["lucide-eye"] = "rbxassetid://10723346959",
  ["lucide-eye-off"] = "rbxassetid://10723346871",
  ["lucide-factory"] = "rbxassetid://10723347051",
  ["lucide-fan"] = "rbxassetid://10723354359",
  ["lucide-fast-forward"] = "rbxassetid://10723354521",
  ["lucide-feather"] = "rbxassetid://10723354671",
  ["lucide-figma"] = "rbxassetid://10723354801",
  ["lucide-file"] = "rbxassetid://10723374641",
  ["lucide-file-archive"] = "rbxassetid://10723354921",
  ["lucide-file-audio"] = "rbxassetid://10723355148",
  ["lucide-file-audio-2"] = "rbxassetid://10723355026",
  ["lucide-file-axis-3d"] = "rbxassetid://10723355272",
  ["lucide-file-badge"] = "rbxassetid://10723355622",
  ["lucide-file-badge-2"] = "rbxassetid://10723355451",
  ["lucide-file-bar-chart"] = "rbxassetid://10723355887",
  ["lucide-file-bar-chart-2"] = "rbxassetid://10723355746",
  ["lucide-file-box"] = "rbxassetid://10723355989",
  ["lucide-file-check"] = "rbxassetid://10723356210",
  ["lucide-file-check-2"] = "rbxassetid://10723356100",
  ["lucide-file-clock"] = "rbxassetid://10723356329",
  ["lucide-file-code"] = "rbxassetid://10723356507",
  ["lucide-file-cog"] = "rbxassetid://10723356830",
  ["lucide-file-cog-2"] = "rbxassetid://10723356676",
  ["lucide-file-diff"] = "rbxassetid://10723357039",
  ["lucide-file-digit"] = "rbxassetid://10723357151",
  ["lucide-file-down"] = "rbxassetid://10723357322",
  ["lucide-file-edit"] = "rbxassetid://10723357495",
  ["lucide-file-heart"] = "rbxassetid://10723357637",
  ["lucide-file-image"] = "rbxassetid://10723357790",
  ["lucide-file-input"] = "rbxassetid://10723357933",
  ["lucide-file-json"] = "rbxassetid://10723364435",
  ["lucide-file-json-2"] = "rbxassetid://10723364361",
  ["lucide-file-key"] = "rbxassetid://10723364605",
  ["lucide-file-key-2"] = "rbxassetid://10723364515",
  ["lucide-file-line-chart"] = "rbxassetid://10723364725",
  ["lucide-file-lock"] = "rbxassetid://10723364957",
  ["lucide-file-lock-2"] = "rbxassetid://10723364861",
  ["lucide-file-minus"] = "rbxassetid://10723365254",
  ["lucide-file-minus-2"] = "rbxassetid://10723365086",
  ["lucide-file-output"] = "rbxassetid://10723365457",
  ["lucide-file-pie-chart"] = "rbxassetid://10723365598",
  ["lucide-file-plus"] = "rbxassetid://10723365877",
  ["lucide-file-plus-2"] = "rbxassetid://10723365766",
  ["lucide-file-question"] = "rbxassetid://10723365987",
  ["lucide-file-scan"] = "rbxassetid://10723366167",
  ["lucide-file-search"] = "rbxassetid://10723366550",
  ["lucide-file-search-2"] = "rbxassetid://10723366340",
  ["lucide-file-signature"] = "rbxassetid://10723366741",
  ["lucide-file-spreadsheet"] = "rbxassetid://10723366962",
  ["lucide-file-symlink"] = "rbxassetid://10723367098",
  ["lucide-file-terminal"] = "rbxassetid://10723367244",
  ["lucide-file-text"] = "rbxassetid://10723367380",
  ["lucide-file-type"] = "rbxassetid://10723367606",
  ["lucide-file-type-2"] = "rbxassetid://10723367509",
  ["lucide-file-up"] = "rbxassetid://10723367734",
  ["lucide-file-video"] = "rbxassetid://10723373884",
  ["lucide-file-video-2"] = "rbxassetid://10723367834",
  ["lucide-file-volume"] = "rbxassetid://10723374172",
  ["lucide-file-volume-2"] = "rbxassetid://10723374030",
  ["lucide-file-warning"] = "rbxassetid://10723374276",
  ["lucide-file-x"] = "rbxassetid://10723374544",
  ["lucide-file-x-2"] = "rbxassetid://10723374378",
  ["lucide-files"] = "rbxassetid://10723374759",
  ["lucide-film"] = "rbxassetid://10723374981",
  ["lucide-filter"] = "rbxassetid://10723375128",
  ["lucide-fingerprint"] = "rbxassetid://10723375250",
  ["lucide-flag"] = "rbxassetid://10723375890",
  ["lucide-flag-off"] = "rbxassetid://10723375443",
  ["lucide-flag-triangle-left"] = "rbxassetid://10723375608",
  ["lucide-flag-triangle-right"] = "rbxassetid://10723375727",
  ["lucide-flame"] = "rbxassetid://10723376114",
  ["lucide-flashlight"] = "rbxassetid://10723376471",
  ["lucide-flashlight-off"] = "rbxassetid://10723376365",
  ["lucide-flask-conical"] = "rbxassetid://10734883986",
  ["lucide-flask-round"] = "rbxassetid://10723376614",
  ["lucide-flip-horizontal"] = "rbxassetid://10723376884",
  ["lucide-flip-horizontal-2"] = "rbxassetid://10723376745",
  ["lucide-flip-vertical"] = "rbxassetid://10723377138",
  ["lucide-flip-vertical-2"] = "rbxassetid://10723377026",
  ["lucide-flower"] = "rbxassetid://10747830374",
  ["lucide-flower-2"] = "rbxassetid://10723377305",
  ["lucide-focus"] = "rbxassetid://10723377537",
  ["lucide-folder"] = "rbxassetid://10723387563",
  ["lucide-folder-archive"] = "rbxassetid://10723384478",
  ["lucide-folder-check"] = "rbxassetid://10723384605",
  ["lucide-folder-clock"] = "rbxassetid://10723384731",
  ["lucide-folder-closed"] = "rbxassetid://10723384893",
  ["lucide-folder-cog"] = "rbxassetid://10723385213",
  ["lucide-folder-cog-2"] = "rbxassetid://10723385036",
  ["lucide-folder-down"] = "rbxassetid://10723385338",
  ["lucide-folder-edit"] = "rbxassetid://10723385445",
  ["lucide-folder-heart"] = "rbxassetid://10723385545",
  ["lucide-folder-input"] = "rbxassetid://10723385721",
  ["lucide-folder-key"] = "rbxassetid://10723385848",
  ["lucide-folder-lock"] = "rbxassetid://10723386005",
  ["lucide-folder-minus"] = "rbxassetid://10723386127",
  ["lucide-folder-open"] = "rbxassetid://10723386277",
  ["lucide-folder-output"] = "rbxassetid://10723386386",
  ["lucide-folder-plus"] = "rbxassetid://10723386531",
  ["lucide-folder-search"] = "rbxassetid://10723386787",
  ["lucide-folder-search-2"] = "rbxassetid://10723386674",
  ["lucide-folder-symlink"] = "rbxassetid://10723386930",
  ["lucide-folder-tree"] = "rbxassetid://10723387085",
  ["lucide-folder-up"] = "rbxassetid://10723387265",
  ["lucide-folder-x"] = "rbxassetid://10723387448",
  ["lucide-folders"] = "rbxassetid://10723387721",
  ["lucide-form-input"] = "rbxassetid://10723387841",
  ["lucide-forward"] = "rbxassetid://10723388016",
  ["lucide-frame"] = "rbxassetid://10723394389",
  ["lucide-framer"] = "rbxassetid://10723394565",
  ["lucide-frown"] = "rbxassetid://10723394681",
  ["lucide-fuel"] = "rbxassetid://10723394846",
  ["lucide-function-square"] = "rbxassetid://10723395041",
  ["lucide-gamepad"] = "rbxassetid://10723395457",
  ["lucide-gamepad-2"] = "rbxassetid://10723395215",
  ["lucide-gauge"] = "rbxassetid://10723395708",
  ["lucide-gavel"] = "rbxassetid://10723395896",
  ["lucide-gem"] = "rbxassetid://10723396000",
  ["lucide-ghost"] = "rbxassetid://10723396107",
  ["lucide-gift"] = "rbxassetid://10723396402",
  ["lucide-gift-card"] = "rbxassetid://10723396225",
  ["lucide-git-branch"] = "rbxassetid://10723396676",
  ["lucide-git-branch-plus"] = "rbxassetid://10723396542",
  ["lucide-git-commit"] = "rbxassetid://10723396812",
  ["lucide-git-compare"] = "rbxassetid://10723396954",
  ["lucide-git-fork"] = "rbxassetid://10723397049",
  ["lucide-git-merge"] = "rbxassetid://10723397165",
  ["lucide-git-pull-request"] = "rbxassetid://10723397431",
  ["lucide-git-pull-request-closed"] = "rbxassetid://10723397268",
  ["lucide-git-pull-request-draft"] = "rbxassetid://10734884302",
  ["lucide-glass"] = "rbxassetid://10723397788",
  ["lucide-glass-2"] = "rbxassetid://10723397529",
  ["lucide-glass-water"] = "rbxassetid://10723397678",
  ["lucide-glasses"] = "rbxassetid://10723397895",
  ["lucide-globe"] = "rbxassetid://10723404337",
  ["lucide-globe-2"] = "rbxassetid://10723398002",
  ["lucide-grab"] = "rbxassetid://10723404472",
  ["lucide-graduation-cap"] = "rbxassetid://10723404691",
  ["lucide-grape"] = "rbxassetid://10723404822",
  ["lucide-grid"] = "rbxassetid://10723404936",
  ["lucide-grip-horizontal"] = "rbxassetid://10723405089",
  ["lucide-grip-vertical"] = "rbxassetid://10723405236",
  ["lucide-hammer"] = "rbxassetid://10723405360",
  ["lucide-hand"] = "rbxassetid://10723405649",
  ["lucide-hand-metal"] = "rbxassetid://10723405508",
  ["lucide-hard-drive"] = "rbxassetid://10723405749",
  ["lucide-hard-hat"] = "rbxassetid://10723405859",
  ["lucide-hash"] = "rbxassetid://10723405975",
  ["lucide-haze"] = "rbxassetid://10723406078",
  ["lucide-headphones"] = "rbxassetid://10723406165",
  ["lucide-heart"] = "rbxassetid://10723406885",
  ["lucide-heart-crack"] = "rbxassetid://10723406299",
  ["lucide-heart-handshake"] = "rbxassetid://10723406480",
  ["lucide-heart-off"] = "rbxassetid://10723406662",
  ["lucide-heart-pulse"] = "rbxassetid://10723406795",
  ["lucide-help-circle"] = "rbxassetid://10723406988",
  ["lucide-hexagon"] = "rbxassetid://10723407092",
  ["lucide-highlighter"] = "rbxassetid://10723407192",
  ["lucide-history"] = "rbxassetid://10723407335",
  ["lucide-home"] = "rbxassetid://10723407389",
  ["lucide-hourglass"] = "rbxassetid://10723407498",
  ["lucide-ice-cream"] = "rbxassetid://10723414308",
  ["lucide-image"] = "rbxassetid://10723415040",
  ["lucide-image-minus"] = "rbxassetid://10723414487",
  ["lucide-image-off"] = "rbxassetid://10723414677",
  ["lucide-image-plus"] = "rbxassetid://10723414827",
  ["lucide-import"] = "rbxassetid://10723415205",
  ["lucide-inbox"] = "rbxassetid://10723415335",
  ["lucide-indent"] = "rbxassetid://10723415494",
  ["lucide-indian-rupee"] = "rbxassetid://10723415642",
  ["lucide-infinity"] = "rbxassetid://10723415766",
  ["lucide-info"] = "rbxassetid://10723415903",
  ["lucide-inspect"] = "rbxassetid://10723416057",
  ["lucide-italic"] = "rbxassetid://10723416195",
  ["lucide-japanese-yen"] = "rbxassetid://10723416363",
  ["lucide-joystick"] = "rbxassetid://10723416527",
  ["lucide-key"] = "rbxassetid://10723416652",
  ["lucide-keyboard"] = "rbxassetid://10723416765",
  ["lucide-lamp"] = "rbxassetid://10723417513",
  ["lucide-lamp-ceiling"] = "rbxassetid://10723416922",
  ["lucide-lamp-desk"] = "rbxassetid://10723417016",
  ["lucide-lamp-floor"] = "rbxassetid://10723417131",
  ["lucide-lamp-wall-down"] = "rbxassetid://10723417240",
  ["lucide-lamp-wall-up"] = "rbxassetid://10723417356",
  ["lucide-landmark"] = "rbxassetid://10723417608",
  ["lucide-languages"] = "rbxassetid://10723417703",
  ["lucide-laptop"] = "rbxassetid://10723423881",
  ["lucide-laptop-2"] = "rbxassetid://10723417797",
  ["lucide-lasso"] = "rbxassetid://10723424235",
  ["lucide-lasso-select"] = "rbxassetid://10723424058",
  ["lucide-laugh"] = "rbxassetid://10723424372",
  ["lucide-layers"] = "rbxassetid://10723424505",
  ["lucide-layout"] = "rbxassetid://10723425376",
  ["lucide-layout-dashboard"] = "rbxassetid://10723424646",
  ["lucide-layout-grid"] = "rbxassetid://10723424838",
  ["lucide-layout-list"] = "rbxassetid://10723424963",
  ["lucide-layout-template"] = "rbxassetid://10723425187",
  ["lucide-leaf"] = "rbxassetid://10723425539",
  ["lucide-library"] = "rbxassetid://10723425615",
  ["lucide-life-buoy"] = "rbxassetid://10723425685",
  ["lucide-lightbulb"] = "rbxassetid://10723425852",
  ["lucide-lightbulb-off"] = "rbxassetid://10723425762",
  ["lucide-line-chart"] = "rbxassetid://10723426393",
  ["lucide-link"] = "rbxassetid://10723426722",
  ["lucide-link-2"] = "rbxassetid://10723426595",
  ["lucide-link-2-off"] = "rbxassetid://10723426513",
  ["lucide-list"] = "rbxassetid://10723433811",
  ["lucide-list-checks"] = "rbxassetid://10734884548",
  ["lucide-list-end"] = "rbxassetid://10723426886",
  ["lucide-list-minus"] = "rbxassetid://10723426986",
  ["lucide-list-music"] = "rbxassetid://10723427081",
  ["lucide-list-ordered"] = "rbxassetid://10723427199",
  ["lucide-list-plus"] = "rbxassetid://10723427334",
  ["lucide-list-start"] = "rbxassetid://10723427494",
  ["lucide-list-video"] = "rbxassetid://10723427619",
  ["lucide-list-x"] = "rbxassetid://10723433655",
  ["lucide-loader"] = "rbxassetid://10723434070",
  ["lucide-loader-2"] = "rbxassetid://10723433935",
  ["lucide-locate"] = "rbxassetid://10723434557",
  ["lucide-locate-fixed"] = "rbxassetid://10723434236",
  ["lucide-locate-off"] = "rbxassetid://10723434379",
  ["lucide-lock"] = "rbxassetid://10723434711",
  ["lucide-log-in"] = "rbxassetid://10723434830",
  ["lucide-log-out"] = "rbxassetid://10723434906",
  ["lucide-luggage"] = "rbxassetid://10723434993",
  ["lucide-magnet"] = "rbxassetid://10723435069",
  ["lucide-mail"] = "rbxassetid://10734885430",
  ["lucide-mail-check"] = "rbxassetid://10723435182",
  ["lucide-mail-minus"] = "rbxassetid://10723435261",
  ["lucide-mail-open"] = "rbxassetid://10723435342",
  ["lucide-mail-plus"] = "rbxassetid://10723435443",
  ["lucide-mail-question"] = "rbxassetid://10723435515",
  ["lucide-mail-search"] = "rbxassetid://10734884739",
  ["lucide-mail-warning"] = "rbxassetid://10734885015",
  ["lucide-mail-x"] = "rbxassetid://10734885247",
  ["lucide-mails"] = "rbxassetid://10734885614",
  ["lucide-map"] = "rbxassetid://10734886202",
  ["lucide-map-pin"] = "rbxassetid://10734886004",
  ["lucide-map-pin-off"] = "rbxassetid://10734885803",
  ["lucide-maximize"] = "rbxassetid://10734886735",
  ["lucide-maximize-2"] = "rbxassetid://10734886496",
  ["lucide-medal"] = "rbxassetid://10734887072",
  ["lucide-megaphone"] = "rbxassetid://10734887454",
  ["lucide-megaphone-off"] = "rbxassetid://10734887311",
  ["lucide-meh"] = "rbxassetid://10734887603",
  ["lucide-menu"] = "rbxassetid://10734887784",
  ["lucide-message-circle"] = "rbxassetid://10734888000",
  ["lucide-message-square"] = "rbxassetid://10734888228",
  ["lucide-mic"] = "rbxassetid://10734888864",
  ["lucide-mic-2"] = "rbxassetid://10734888430",
  ["lucide-mic-off"] = "rbxassetid://10734888646",
  ["lucide-microscope"] = "rbxassetid://10734889106",
  ["lucide-microwave"] = "rbxassetid://10734895076",
  ["lucide-milestone"] = "rbxassetid://10734895310",
  ["lucide-minimize"] = "rbxassetid://10734895698",
  ["lucide-minimize-2"] = "rbxassetid://10734895530",
  ["lucide-minus"] = "rbxassetid://10734896206",
  ["lucide-minus-circle"] = "rbxassetid://10734895856",
  ["lucide-minus-square"] = "rbxassetid://10734896029",
  ["lucide-monitor"] = "rbxassetid://10734896881",
  ["lucide-monitor-off"] = "rbxassetid://10734896360",
  ["lucide-monitor-speaker"] = "rbxassetid://10734896512",
  ["lucide-moon"] = "rbxassetid://10734897102",
  ["lucide-more-horizontal"] = "rbxassetid://10734897250",
  ["lucide-more-vertical"] = "rbxassetid://10734897387",
  ["lucide-mountain"] = "rbxassetid://10734897956",
  ["lucide-mountain-snow"] = "rbxassetid://10734897665",
  ["lucide-mouse"] = "rbxassetid://10734898592",
  ["lucide-mouse-pointer"] = "rbxassetid://10734898476",
  ["lucide-mouse-pointer-2"] = "rbxassetid://10734898194",
  ["lucide-mouse-pointer-click"] = "rbxassetid://10734898355",
  ["lucide-move"] = "rbxassetid://10734900011",
  ["lucide-move-3d"] = "rbxassetid://10734898756",
  ["lucide-move-diagonal"] = "rbxassetid://10734899164",
  ["lucide-move-diagonal-2"] = "rbxassetid://10734898934",
  ["lucide-move-horizontal"] = "rbxassetid://10734899414",
  ["lucide-move-vertical"] = "rbxassetid://10734899821",
  ["lucide-music"] = "rbxassetid://10734905958",
  ["lucide-music-2"] = "rbxassetid://10734900215",
  ["lucide-music-3"] = "rbxassetid://10734905665",
  ["lucide-music-4"] = "rbxassetid://10734905823",
  ["lucide-navigation"] = "rbxassetid://10734906744",
  ["lucide-navigation-2"] = "rbxassetid://10734906332",
  ["lucide-navigation-2-off"] = "rbxassetid://10734906144",
  ["lucide-navigation-off"] = "rbxassetid://10734906580",
  ["lucide-network"] = "rbxassetid://10734906975",
  ["lucide-newspaper"] = "rbxassetid://10734907168",
  ["lucide-octagon"] = "rbxassetid://10734907361",
  ["lucide-option"] = "rbxassetid://10734907649",
  ["lucide-outdent"] = "rbxassetid://10734907933",
  ["lucide-package"] = "rbxassetid://10734909540",
  ["lucide-package-2"] = "rbxassetid://10734908151",
  ["lucide-package-check"] = "rbxassetid://10734908384",
  ["lucide-package-minus"] = "rbxassetid://10734908626",
  ["lucide-package-open"] = "rbxassetid://10734908793",
  ["lucide-package-plus"] = "rbxassetid://10734909016",
  ["lucide-package-search"] = "rbxassetid://10734909196",
  ["lucide-package-x"] = "rbxassetid://10734909375",
  ["lucide-paint-bucket"] = "rbxassetid://10734909847",
  ["lucide-paintbrush"] = "rbxassetid://10734910187",
  ["lucide-paintbrush-2"] = "rbxassetid://10734910030",
  ["lucide-palette"] = "rbxassetid://10734910430",
  ["lucide-palmtree"] = "rbxassetid://10734910680",
  ["lucide-paperclip"] = "rbxassetid://10734910927",
  ["lucide-party-popper"] = "rbxassetid://10734918735",
  ["lucide-pause"] = "rbxassetid://10734919336",
  ["lucide-pause-circle"] = "rbxassetid://10735024209",
  ["lucide-pause-octagon"] = "rbxassetid://10734919143",
  ["lucide-pen-tool"] = "rbxassetid://10734919503",
  ["lucide-pencil"] = "rbxassetid://10734919691",
  ["lucide-percent"] = "rbxassetid://10734919919",
  ["lucide-person-standing"] = "rbxassetid://10734920149",
  ["lucide-phone"] = "rbxassetid://10734921524",
  ["lucide-phone-call"] = "rbxassetid://10734920305",
  ["lucide-phone-forwarded"] = "rbxassetid://10734920508",
  ["lucide-phone-incoming"] = "rbxassetid://10734920694",
  ["lucide-phone-missed"] = "rbxassetid://10734920845",
  ["lucide-phone-off"] = "rbxassetid://10734921077",
  ["lucide-phone-outgoing"] = "rbxassetid://10734921288",
  ["lucide-pie-chart"] = "rbxassetid://10734921727",
  ["lucide-piggy-bank"] = "rbxassetid://10734921935",
  ["lucide-pin"] = "rbxassetid://10734922324",
  ["lucide-pin-off"] = "rbxassetid://10734922180",
  ["lucide-pipette"] = "rbxassetid://10734922497",
  ["lucide-pizza"] = "rbxassetid://10734922774",
  ["lucide-plane"] = "rbxassetid://10734922971",
  ["lucide-play"] = "rbxassetid://10734923549",
  ["lucide-play-circle"] = "rbxassetid://10734923214",
  ["lucide-plus"] = "rbxassetid://10734924532",
  ["lucide-plus-circle"] = "rbxassetid://10734923868",
  ["lucide-plus-square"] = "rbxassetid://10734924219",
  ["lucide-podcast"] = "rbxassetid://10734929553",
  ["lucide-pointer"] = "rbxassetid://10734929723",
  ["lucide-pound-sterling"] = "rbxassetid://10734929981",
  ["lucide-power"] = "rbxassetid://10734930466",
  ["lucide-power-off"] = "rbxassetid://10734930257",
  ["lucide-printer"] = "rbxassetid://10734930632",
  ["lucide-puzzle"] = "rbxassetid://10734930886",
  ["lucide-quote"] = "rbxassetid://10734931234",
  ["lucide-radio"] = "rbxassetid://10734931596",
  ["lucide-radio-receiver"] = "rbxassetid://10734931402",
  ["lucide-rectangle-horizontal"] = "rbxassetid://10734931777",
  ["lucide-rectangle-vertical"] = "rbxassetid://10734932081",
  ["lucide-recycle"] = "rbxassetid://10734932295",
  ["lucide-redo"] = "rbxassetid://10734932822",
  ["lucide-redo-2"] = "rbxassetid://10734932586",
  ["lucide-refresh-ccw"] = "rbxassetid://10734933056",
  ["lucide-refresh-cw"] = "rbxassetid://10734933222",
  ["lucide-refrigerator"] = "rbxassetid://10734933465",
  ["lucide-regex"] = "rbxassetid://10734933655",
  ["lucide-repeat"] = "rbxassetid://10734933966",
  ["lucide-repeat-1"] = "rbxassetid://10734933826",
  ["lucide-reply"] = "rbxassetid://10734934252",
  ["lucide-reply-all"] = "rbxassetid://10734934132",
  ["lucide-rewind"] = "rbxassetid://10734934347",
  ["lucide-rocket"] = "rbxassetid://10734934585",
  ["lucide-rocking-chair"] = "rbxassetid://10734939942",
  ["lucide-rotate-3d"] = "rbxassetid://10734940107",
  ["lucide-rotate-ccw"] = "rbxassetid://10734940376",
  ["lucide-rotate-cw"] = "rbxassetid://10734940654",
  ["lucide-rss"] = "rbxassetid://10734940825",
  ["lucide-ruler"] = "rbxassetid://10734941018",
  ["lucide-russian-ruble"] = "rbxassetid://10734941199",
  ["lucide-sailboat"] = "rbxassetid://10734941354",
  ["lucide-save"] = "rbxassetid://10734941499",
  ["lucide-scale"] = "rbxassetid://10734941912",
  ["lucide-scale-3d"] = "rbxassetid://10734941739",
  ["lucide-scaling"] = "rbxassetid://10734942072",
  ["lucide-scan"] = "rbxassetid://10734942565",
  ["lucide-scan-face"] = "rbxassetid://10734942198",
  ["lucide-scan-line"] = "rbxassetid://10734942351",
  ["lucide-scissors"] = "rbxassetid://10734942778",
  ["lucide-screen-share"] = "rbxassetid://10734943193",
  ["lucide-screen-share-off"] = "rbxassetid://10734942967",
  ["lucide-scroll"] = "rbxassetid://10734943448",
  ["lucide-search"] = "rbxassetid://10734943674",
  ["lucide-send"] = "rbxassetid://10734943902",
  ["lucide-separator-horizontal"] = "rbxassetid://10734944115",
  ["lucide-separator-vertical"] = "rbxassetid://10734944326",
  ["lucide-server"] = "rbxassetid://10734949856",
  ["lucide-server-cog"] = "rbxassetid://10734944444",
  ["lucide-server-crash"] = "rbxassetid://10734944554",
  ["lucide-server-off"] = "rbxassetid://10734944668",
  ["lucide-settings"] = "rbxassetid://10734950309",
  ["lucide-settings-2"] = "rbxassetid://10734950020",
  ["lucide-share"] = "rbxassetid://10734950813",
  ["lucide-share-2"] = "rbxassetid://10734950553",
  ["lucide-sheet"] = "rbxassetid://10734951038",
  ["lucide-shield"] = "rbxassetid://10734951847",
  ["lucide-shield-alert"] = "rbxassetid://10734951173",
  ["lucide-shield-check"] = "rbxassetid://10734951367",
  ["lucide-shield-close"] = "rbxassetid://10734951535",
  ["lucide-shield-off"] = "rbxassetid://10734951684",
  ["lucide-shirt"] = "rbxassetid://10734952036",
  ["lucide-shopping-bag"] = "rbxassetid://10734952273",
  ["lucide-shopping-cart"] = "rbxassetid://10734952479",
  ["lucide-shovel"] = "rbxassetid://10734952773",
  ["lucide-shower-head"] = "rbxassetid://10734952942",
  ["lucide-shrink"] = "rbxassetid://10734953073",
  ["lucide-shrub"] = "rbxassetid://10734953241",
  ["lucide-shuffle"] = "rbxassetid://10734953451",
  ["lucide-sidebar"] = "rbxassetid://10734954301",
  ["lucide-sidebar-close"] = "rbxassetid://10734953715",
  ["lucide-sidebar-open"] = "rbxassetid://10734954000",
  ["lucide-sigma"] = "rbxassetid://10734954538",
  ["lucide-signal"] = "rbxassetid://10734961133",
  ["lucide-signal-high"] = "rbxassetid://10734954807",
  ["lucide-signal-low"] = "rbxassetid://10734955080",
  ["lucide-signal-medium"] = "rbxassetid://10734955336",
  ["lucide-signal-zero"] = "rbxassetid://10734960878",
  ["lucide-siren"] = "rbxassetid://10734961284",
  ["lucide-skip-back"] = "rbxassetid://10734961526",
  ["lucide-skip-forward"] = "rbxassetid://10734961809",
  ["lucide-skull"] = "rbxassetid://10734962068",
  ["lucide-slack"] = "rbxassetid://10734962339",
  ["lucide-slash"] = "rbxassetid://10734962600",
  ["lucide-slice"] = "rbxassetid://10734963024",
  ["lucide-sliders"] = "rbxassetid://10734963400",
  ["lucide-sliders-horizontal"] = "rbxassetid://10734963191",
  ["lucide-smartphone"] = "rbxassetid://10734963940",
  ["lucide-smartphone-charging"] = "rbxassetid://10734963671",
  ["lucide-smile"] = "rbxassetid://10734964441",
  ["lucide-smile-plus"] = "rbxassetid://10734964188",
  ["lucide-snowflake"] = "rbxassetid://10734964600",
  ["lucide-sofa"] = "rbxassetid://10734964852",
  ["lucide-sort-asc"] = "rbxassetid://10734965115",
  ["lucide-sort-desc"] = "rbxassetid://10734965287",
  ["lucide-speaker"] = "rbxassetid://10734965419",
  ["lucide-sprout"] = "rbxassetid://10734965572",
  ["lucide-square"] = "rbxassetid://10734965702",
  ["lucide-star"] = "rbxassetid://10734966248",
  ["lucide-star-half"] = "rbxassetid://10734965897",
  ["lucide-star-off"] = "rbxassetid://10734966097",
  ["lucide-stethoscope"] = "rbxassetid://10734966384",
  ["lucide-sticker"] = "rbxassetid://10734972234",
  ["lucide-sticky-note"] = "rbxassetid://10734972463",
  ["lucide-stop-circle"] = "rbxassetid://10734972621",
  ["lucide-stretch-horizontal"] = "rbxassetid://10734972862",
  ["lucide-stretch-vertical"] = "rbxassetid://10734973130",
  ["lucide-strikethrough"] = "rbxassetid://10734973290",
  ["lucide-subscript"] = "rbxassetid://10734973457",
  ["lucide-sun"] = "rbxassetid://10734974297",
  ["lucide-sun-dim"] = "rbxassetid://10734973645",
  ["lucide-sun-medium"] = "rbxassetid://10734973778",
  ["lucide-sun-moon"] = "rbxassetid://10734973999",
  ["lucide-sun-snow"] = "rbxassetid://10734974130",
  ["lucide-sunrise"] = "rbxassetid://10734974522",
  ["lucide-sunset"] = "rbxassetid://10734974689",
  ["lucide-superscript"] = "rbxassetid://10734974850",
  ["lucide-swiss-franc"] = "rbxassetid://10734975024",
  ["lucide-switch-camera"] = "rbxassetid://10734975214",
  ["lucide-sword"] = "rbxassetid://10734975486",
  ["lucide-swords"] = "rbxassetid://10734975692",
  ["lucide-syringe"] = "rbxassetid://10734975932",
  ["lucide-table"] = "rbxassetid://10734976230",
  ["lucide-table-2"] = "rbxassetid://10734976097",
  ["lucide-tablet"] = "rbxassetid://10734976394",
  ["lucide-tag"] = "rbxassetid://10734976528",
  ["lucide-tags"] = "rbxassetid://10734976739",
  ["lucide-target"] = "rbxassetid://10734977012",
  ["lucide-tent"] = "rbxassetid://10734981750",
  ["lucide-terminal"] = "rbxassetid://10734982144",
  ["lucide-terminal-square"] = "rbxassetid://10734981995",
  ["lucide-text-cursor"] = "rbxassetid://10734982395",
  ["lucide-text-cursor-input"] = "rbxassetid://10734982297",
  ["lucide-thermometer"] = "rbxassetid://10734983134",
  ["lucide-thermometer-snowflake"] = "rbxassetid://10734982571",
  ["lucide-thermometer-sun"] = "rbxassetid://10734982771",
  ["lucide-thumbs-down"] = "rbxassetid://10734983359",
  ["lucide-thumbs-up"] = "rbxassetid://10734983629",
  ["lucide-ticket"] = "rbxassetid://10734983868",
  ["lucide-timer"] = "rbxassetid://10734984606",
  ["lucide-timer-off"] = "rbxassetid://10734984138",
  ["lucide-timer-reset"] = "rbxassetid://10734984355",
  ["lucide-toggle-left"] = "rbxassetid://10734984834",
  ["lucide-toggle-right"] = "rbxassetid://10734985040",
  ["lucide-tornado"] = "rbxassetid://10734985247",
  ["lucide-toy-brick"] = "rbxassetid://10747361919",
  ["lucide-train"] = "rbxassetid://10747362105",
  ["lucide-trash"] = "rbxassetid://10747362393",
  ["lucide-trash-2"] = "rbxassetid://10747362241",
  ["lucide-tree-deciduous"] = "rbxassetid://10747362534",
  ["lucide-tree-pine"] = "rbxassetid://10747362748",
  ["lucide-trees"] = "rbxassetid://10747363016",
  ["lucide-trending-down"] = "rbxassetid://10747363205",
  ["lucide-trending-up"] = "rbxassetid://10747363465",
  ["lucide-triangle"] = "rbxassetid://10747363621",
  ["lucide-trophy"] = "rbxassetid://10747363809",
  ["lucide-truck"] = "rbxassetid://10747364031",
  ["lucide-tv"] = "rbxassetid://10747364593",
  ["lucide-tv-2"] = "rbxassetid://10747364302",
  ["lucide-type"] = "rbxassetid://10747364761",
  ["lucide-umbrella"] = "rbxassetid://10747364971",
  ["lucide-underline"] = "rbxassetid://10747365191",
  ["lucide-undo"] = "rbxassetid://10747365484",
  ["lucide-undo-2"] = "rbxassetid://10747365359",
  ["lucide-unlink"] = "rbxassetid://10747365771",
  ["lucide-unlink-2"] = "rbxassetid://10747397871",
  ["lucide-unlock"] = "rbxassetid://10747366027",
  ["lucide-upload"] = "rbxassetid://10747366434",
  ["lucide-upload-cloud"] = "rbxassetid://10747366266",
  ["lucide-usb"] = "rbxassetid://10747366606",
  ["lucide-user"] = "rbxassetid://10747373176",
  ["lucide-user-check"] = "rbxassetid://10747371901",
  ["lucide-user-cog"] = "rbxassetid://10747372167",
  ["lucide-user-minus"] = "rbxassetid://10747372346",
  ["lucide-user-plus"] = "rbxassetid://10747372702",
  ["lucide-user-x"] = "rbxassetid://10747372992",
  ["lucide-users"] = "rbxassetid://10747373426",
  ["lucide-utensils"] = "rbxassetid://10747373821",
  ["lucide-utensils-crossed"] = "rbxassetid://10747373629",
  ["lucide-venetian-mask"] = "rbxassetid://10747374003",
  ["lucide-verified"] = "rbxassetid://10747374131",
  ["lucide-vibrate"] = "rbxassetid://10747374489",
  ["lucide-vibrate-off"] = "rbxassetid://10747374269",
  ["lucide-video"] = "rbxassetid://10747374938",
  ["lucide-video-off"] = "rbxassetid://10747374721",
  ["lucide-view"] = "rbxassetid://10747375132",
  ["lucide-voicemail"] = "rbxassetid://10747375281",
  ["lucide-volume"] = "rbxassetid://10747376008",
  ["lucide-volume-1"] = "rbxassetid://10747375450",
  ["lucide-volume-2"] = "rbxassetid://10747375679",
  ["lucide-volume-x"] = "rbxassetid://10747375880",
  ["lucide-wallet"] = "rbxassetid://10747376205",
  ["lucide-wand"] = "rbxassetid://10747376565",
  ["lucide-wand-2"] = "rbxassetid://10747376349",
  ["lucide-watch"] = "rbxassetid://10747376722",
  ["lucide-waves"] = "rbxassetid://10747376931",
  ["lucide-webcam"] = "rbxassetid://10747381992",
  ["lucide-wifi"] = "rbxassetid://10747382504",
  ["lucide-wifi-off"] = "rbxassetid://10747382268",
  ["lucide-wind"] = "rbxassetid://10747382750",
  ["lucide-wrap-text"] = "rbxassetid://10747383065",
  ["lucide-wrench"] = "rbxassetid://10747383470",
  ["lucide-x"] = "rbxassetid://10747384394",
  ["lucide-x-circle"] = "rbxassetid://10747383819",
  ["lucide-x-octagon"] = "rbxassetid://10747384037",
  ["lucide-x-square"] = "rbxassetid://10747384217",
  ["lucide-zoom-in"] = "rbxassetid://10747384552",
  ["lucide-zoom-out"] = "rbxassetid://10747384679"
}

local function ResolveIcon(v)
    if typeof(v) ~= "string" then return v end
    if LucideIcons[v] then return LucideIcons[v] end
    if LucideIcons["lucide-"..v] then return LucideIcons["lucide-"..v] end
    return v
end

-- Responsive helpers --------------------------------------------------------
local function _viewportSize()
    local cam = workspace.CurrentCamera
    return cam and cam.ViewportSize or Vector2.new(800, 600)
end
local function IsMobile_SX()
    local vp = _viewportSize()
    return UserInputService_SX.TouchEnabled
       and not UserInputService_SX.MouseEnabled
        or vp.X < 700
end
local function ResponsiveSize(desktop, mobile)
    return IsMobile_SX() and mobile or desktop
end

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local VirtualUser = game:GetService("VirtualUser")

local Custom = {} do
  Custom.ColorRGB = Color3.fromRGB(255, 45, 60)

  function Custom:Create(Name, Properties, Parent)
    local _instance = Instance.new(Name)

    for i, v in pairs(Properties) do
      if (i == "Image" or i == "IconImage") and typeof(v) == "string" and v:sub(1,7) == "lucide-" then
        v = ResolveIcon(v)
      end
      _instance[i] = v
    end

    if Parent then
      _instance.Parent = Parent
    end

    return _instance
  end

  function Custom:EnabledAFK()
    Player.Idled:Connect(function()
      VirtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
      task.wait(1)
      VirtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    end)
  end
end

Custom:EnabledAFK()

local function OpenClose()
  local ScreenGui = Custom:Create("ScreenGui", {
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling
  }, RunService:IsStudio() and Player.PlayerGui or (gethui() or cloneref(game:GetService("CoreGui")) or game:GetService("CoreGui")))

  local Close_ImageButton = Custom:Create("ImageButton", {
    BackgroundColor3 = Color3.fromRGB(0, 0, 0),
    BorderColor3 = Color3.fromRGB(255, 0, 0),
    BackgroundTransparency = 1,
    Position = UDim2.new(0.1021, 0, 0.0743, 0),
    Size = UDim2.new(0, 59, 0, 49),
    Image = "rbxassetid://136890595976124",
    Visible = false,
  }, ScreenGui)

  local UICorner = Custom:Create("UICorner", {
    Name = "MainCorner",
    CornerRadius = UDim.new(0, 9),
  }, Close_ImageButton)

  local dragging, dragStart, startPos = false, nil, nil

  local function UpdateDraggable(input)
    local delta = input.Position - dragStart
    Close_ImageButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
  end

  Close_ImageButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
      dragging = true
      dragStart = input.Position
      startPos = Close_ImageButton.Position

      input.Changed:Connect(function()
        if input.UserInputState == Enum.UserInputState.End then
          dragging = false
        end
      end)
    end
  end)

  Close_ImageButton.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
      UpdateDraggable(input)
    end
  end)

  return Close_ImageButton
end

local Open_Close = OpenClose()

local function MakeDraggable(topbarobject, object)
  local dragging, dragStart, startPos = false, nil, nil

  local function UpdatePos(input)
    local delta = input.Position - dragStart
    local newPos = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    object.Position = newPos
  end

  topbarobject.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
      dragging = true
      dragStart = input.Position
      startPos = object.Position

      input.Changed:Connect(function()
        if input.UserInputState == Enum.UserInputState.End then
          dragging = false
        end
      end)
    end
  end)

  topbarobject.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
      UpdatePos(input)
    end
  end)
end

function CircleClick(Button, X, Y)
	task.spawn(function()
		Button.ClipsDescendants = true
		
		local Circle = Instance.new("ImageLabel")
		Circle.Image = "rbxassetid://106471194043211"
		Circle.ImageColor3 = Color3.fromRGB(80, 80, 80)
		Circle.ImageTransparency = 0.8999999761581421
		Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Circle.BackgroundTransparency = 1
		Circle.ZIndex = 10
		Circle.Name = "Circle"
		Circle.Parent = Button
		
		local NewX = X - Button.AbsolutePosition.X
		local NewY = Y - Button.AbsolutePosition.Y
		Circle.Position = UDim2.new(0, NewX, 0, NewY)

		local Size = math.max(Button.AbsoluteSize.X, Button.AbsoluteSize.Y) * 1.5

		local Time = 0.5
		local TweenInfo = TweenInfo.new(Time, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

		local Tween = TweenService:Create(Circle, TweenInfo, {
			Size = UDim2.new(0, Size, 0, Size),
			Position = UDim2.new(0.5, -Size/2, 0.5, -Size/2)
		})
		
		Tween:Play()
		
		Tween.Completed:Connect(function()
			for i = 1, 10 do
				Circle.ImageTransparency = Circle.ImageTransparency + 0.01
				wait(Time / 10)
			end
			Circle:Destroy()
		end)
	end)
end

local Speed_Library, Notification = {}, {}

Speed_Library.Unloaded = false

function Speed_Library:SetNotification(Config)
  local Title = Config[1] or Config.Title or ""
  local Description = Config[2] or Config.Description or ""
	local Content = Config[3] or Config.Content or ""
  local Time = Config[5] or Config.Time or 0.5
  local Delay = Config[6] or Config.Delay or 5

  local NotificationGui = Custom:Create("ScreenGui", {
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
  }, RunService:IsStudio() and Player.PlayerGui or (gethui() or cloneref(game:GetService("CoreGui")) or game:GetService("CoreGui")))

  local NotificationLayout = Custom:Create("Frame", {
    AnchorPoint = Vector2.new(1, 1),
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 0.999,
    BorderColor3 = Color3.fromRGB(0, 0, 0),
    BorderSizePixel = 0,
    Position = UDim2.new(1, -30, 1, -30),
    Size = UDim2.new(0, 320, 1, 0),
    Name = "NotificationLayout"
  }, NotificationGui)

  local Count = 0

  NotificationLayout.ChildRemoved:Connect(function()
    Count = 0
    local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
    
    for _, v in ipairs(NotificationLayout:GetChildren()) do
      local NewPOS = UDim2.new(0, 0, 1, -((v.Size.Y.Offset + 12) * Count))
      local tween = TweenService:Create(v, tweenInfo, {Position = NewPOS})
      tween:Play()
      Count = Count + 1
    end
  end)

  local _Count = 0
  for _, v in ipairs(NotificationLayout:GetChildren()) do
    _Count = -(v.Position.Y.Offset) + v.Size.Y.Offset + 12
  end

  local NotificationFrame = Custom:Create("Frame", {
    BackgroundColor3 = Color3.fromRGB(0, 0, 0),
    BorderColor3 = Color3.fromRGB(0, 0, 0),
    BorderSizePixel = 0,
    Size = UDim2.new(1, 0, 0, 150),
    Name = "NotificationFrame",
    BackgroundTransparency = 1,
    AnchorPoint = Vector2.new(0, 1),
    Position = UDim2.new(0, 0, 1, -(_Count))
  }, NotificationLayout)

  local NotificationFrameReal = Custom:Create("Frame", {
    BackgroundColor3 = Color3.fromRGB(0, 0, 0),
    BorderColor3 = Color3.fromRGB(0, 0, 0),
    BorderSizePixel = 0,
    Position = UDim2.new(0, 400, 0, 0),
    Size = UDim2.new(1, 0, 1, 0),
    Name = "NotificationFrameReal"
  }, NotificationFrame)

  Custom:Create("UICorner", {
    CornerRadius = UDim.new(0, 8)
  }, NotificationFrameReal)

  local DropShadowHolder = Custom:Create("Frame", {
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Size = UDim2.new(1, 0, 1, 0),
    ZIndex = 0,
    Name = "DropShadowHolder",
    Parent = NotificationFrameReal
  })

  local DropShadow = Custom:Create("ImageLabel", {
    Image = "",
    ImageColor3 = Color3.fromRGB(0, 0, 0),
    ImageTransparency = 0.5,
    ScaleType = Enum.ScaleType.Slice,
    SliceCenter = Rect.new(49, 49, 450, 450),
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Position = UDim2.new(0.5, 0, 0.5, 0),
    Size = UDim2.new(1, 47, 1, 47),
    ZIndex = 0,
    Name = "DropShadow",
    Parent = DropShadowHolder
  })
 
  local Top = Custom:Create("Frame", {
    BackgroundColor3 = Color3.fromRGB(0, 0, 0),
    BackgroundTransparency = 0.999,
    BorderColor3 = Color3.fromRGB(0, 0, 0),
    BorderSizePixel = 0,
    Size = UDim2.new(1, 0, 0, 36),
    Name = "Top",
    Parent = NotificationFrameReal
  })

  local TextLabel = Custom:Create("TextLabel", {
    Font = Enum.Font.GothamBlack,
    Text = Title,
    TextColor3 = Custom.ColorRGB,
    TextSize = 16,
    TextXAlignment = Enum.TextXAlignment.Left,
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 0.999,
    BorderColor3 = Color3.fromRGB(0, 0, 0),
    BorderSizePixel = 0,
    Size = UDim2.new(1, 0, 1, 0),
    Position = UDim2.new(0, 10, 0, 0),
    Parent = Top
  })

  Custom:Create("UIStroke", {
    Color = Color3.fromRGB(255, 255, 255),
    Thickness = 0.3,
    Parent = TextLabel
  })

  Custom:Create("UICorner", {
    Parent = Top,
    CornerRadius = UDim.new(0, 5)
  })

  local TextLabel1 = Custom:Create("TextLabel", {
    Font = Enum.Font.GothamBold,
    Text = Description,
    TextColor3 = Custom.ColorRGB,
    TextSize = 14,
    TextXAlignment = Enum.TextXAlignment.Left,
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 0.999,
    BorderColor3 = Color3.fromRGB(0, 0, 0),
    BorderSizePixel = 0,
    Size = UDim2.new(1, 0, 1, 0),
    Position = UDim2.new(0, TextLabel.TextBounds.X + 15, 0, 0),
    Parent = Top
  })

  Custom:Create("UIStroke", {
    Color = Custom.ColorRGB,
    Thickness = 0.4,
    Parent = TextLabel1
  })

  local Close = Custom:Create("TextButton", {
    Font = Enum.Font.GothamBold,
    Text = "X",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 18,
    AnchorPoint = Vector2.new(1, 0.5),
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 0.999,
    BorderColor3 = Color3.fromRGB(0, 0, 0),
    BorderSizePixel = 0,
    Position = UDim2.new(1, -5, 0.5, 0),
    Size = UDim2.new(0, 25, 0, 25),
    Name = "Close",
    Parent = Top
  })

  local TextLabel2 = Custom:Create("TextLabel", {
    Font = Enum.Font.GothamBold,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 13,
    Text = Content,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Top,
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 0.999,
    TextColor3 = Color3.fromRGB(150, 150, 150),
    BorderColor3 = Color3.fromRGB(0, 0, 0),
    BorderSizePixel = 0,
    Position = UDim2.new(0, 10, 0, 27),
    Size = UDim2.new(1, -20, 0, 13),
    Parent = NotificationFrameReal
  })

  TextLabel2.Size = UDim2.new(1, -20, 0, 13 + (13 * (TextLabel2.TextBounds.X // TextLabel2.AbsoluteSize.X)))
  TextLabel2.TextWrapped = true

  if TextLabel2.AbsoluteSize.Y < 27 then
    NotificationFrame.Size = UDim2.new(1, 0, 0, 65)
  else
    NotificationFrame.Size = UDim2.new(1, 0, 0, TextLabel2.AbsoluteSize.Y + 40)
  end

  local Waitted = false

  function Notification:Close()
    if Waitted then return false end
    Waitted = true

    local tween = TweenService:Create(NotificationFrameReal,TweenInfo.new(tonumber(Time), Enum.EasingStyle.Back, Enum.EasingDirection.InOut),{Position = UDim2.new(0, 400, 0, 0)})
    tween:Play()

    task.wait(tonumber(Time) / 1.2)

    NotificationFrame:Destroy()

    Waitted = false
  end

  Close.Activated:Connect(function()
    Notification:Close()
	end)

  TweenService:Create(NotificationFrameReal, TweenInfo.new(tonumber(Time), Enum.EasingStyle.Back, Enum.EasingDirection.InOut), {Position = UDim2.new(0, 0, 0, 0)} ):Play()
  task.wait(tonumber(Delay))
  Notification:Close()

  return Notification
end

function Speed_Library:CreateWindow(Config)
  local Title = Config[1] or Config.Title or ""
  local Description = Config[2] or Config.Description or ""
  local TabWidth = Config[3] or Config["Tab Width"] or 120
  local SizeUi = Config[4] or Config.SizeUi or UDim2.fromOffset(550, 315)
  -- Responsive: shrink window & tab rail on phones
  if IsMobile_SX() then
    local vp = _viewportSize()
    local w = math.min(vp.X - 24, 460)
    local h = math.min(vp.Y - 80, 420)
    SizeUi  = UDim2.fromOffset(w, h)
    TabWidth = math.clamp(math.floor(w * 0.30), 86, 110)
  end
  -- React to viewport rotation/resize
  task.spawn(function()
    local cam = workspace.CurrentCamera
    if not cam then return end
    cam:GetPropertyChangedSignal("ViewportSize"):Connect(function()
      -- soft reflow hint; user can recreate the window if needed
    end)
  end)

  local Funcs = {}

  local SpeedHubXGui = Custom:Create("ScreenGui", {
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling
  }, RunService:IsStudio() and Player.PlayerGui or (gethui() or cloneref(game:GetService("CoreGui")) or game:GetService("CoreGui")))

  local DropShadowHolder = Custom:Create("Frame", {
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Size = UDim2.new(0, 455, 0, 350),
    ZIndex = 0,
    Name = "DropShadowHolder",
    Position = UDim2.new(0, (SpeedHubXGui.AbsoluteSize.X // 2 - 455 // 2), 0, (SpeedHubXGui.AbsoluteSize.Y // 2 - 350 // 2))
  }, SpeedHubXGui)

  local DropShadow = Custom:Create("ImageLabel", {
    Image = "",
    ImageColor3 = Color3.fromRGB(15, 15, 15),
    ImageTransparency = 0.5,
    ScaleType = Enum.ScaleType.Slice,
    SliceCenter = Rect.new(49, 49, 450, 450),
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Position = UDim2.new(0.5, 0, 0.5, 0),
    Size = SizeUi,
    ZIndex = 0,
    Name = "DropShadow"
  }, DropShadowHolder)

  local Main = Custom:Create("Frame", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundColor3 = Color3.fromRGB(10, 10, 12),
    BackgroundTransparency = 0.12,
    BorderColor3 = Color3.fromRGB(0, 0, 0),
    BorderSizePixel = 0,
    Position = UDim2.new(0.5, 0, 0.5, 0),
    Size = SizeUi,
    Name = "Main"
  }, DropShadow)

  Custom:Create("UICorner", { CornerRadius = UDim.new(0, 12) }, Main)

  Custom:Create("UIStroke", {
    Color = Color3.fromRGB(255, 45, 60),
    Thickness = 1.4,
    Transparency = 0.25
  }, Main)

  local Top = Custom:Create("Frame", {
    BackgroundColor3 = Color3.fromRGB(0, 0, 0),
    BackgroundTransparency = 0.9990000128746033,
    BorderColor3 = Color3.fromRGB(0, 0, 0),
    BorderSizePixel = 0,
    Size = UDim2.new(1, 0, 0, 38),
    Name = "Top"
  }, Main)

  local TextLabel = Custom:Create("TextLabel", {
    Font = Enum.Font.GothamBlack,
    Text = Title,
    TextColor3 = Custom.ColorRGB,
    TextSize = 16,
    TextXAlignment = Enum.TextXAlignment.Left,
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 0.9990000128746033,
    BorderColor3 = Color3.fromRGB(0, 0, 0),
    BorderSizePixel = 0,
    Size = UDim2.new(1, -100, 1, 0),
    Position = UDim2.new(0, 10, 0, 0)
  }, Top)

  Custom:Create("UICorner", { CornerRadius = UDim.new(0, 12) }, Top)

  local TextLabel1 = Custom:Create("TextLabel", {
    Font = Enum.Font.GothamBold,
    Text = Description,
    TextColor3 = Custom.ColorRGB,
    TextSize = 14,
    TextXAlignment = Enum.TextXAlignment.Left,
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 0.9990000128746033,
    BorderColor3 = Color3.fromRGB(0, 0, 0),
    BorderSizePixel = 0,
    Size = UDim2.new(1, -(TextLabel.TextBounds.X + 104), 1, 0),
    Position = UDim2.new(0, TextLabel.TextBounds.X + 15, 0, 0)
  }, Top)

  Custom:Create("UIStroke", {
    Color = Custom.ColorRGB,
    Thickness = 0.4
  }, TextLabel1)

  local Close = Custom:Create("TextButton", {
    Font = Enum.Font.GothamBold,
    Text = "X",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 14,
    AnchorPoint = Vector2.new(1, 0.5),
    BackgroundColor3 = Custom.ColorRGB,
    BackgroundTransparency = 0.35,
    BorderColor3 = Color3.fromRGB(0, 0, 0),
    BorderSizePixel = 0,
    Position = UDim2.new(1, -8, 0.5, 0),
    Size = UDim2.new(0, 26, 0, 22),
    Name = "Close"
  }, Top)
  Custom:Create("UICorner", { CornerRadius = UDim.new(0, 8) }, Close)
  Custom:Create("UIStroke", { Color = Custom.ColorRGB, Thickness = 1, Transparency = 0.4 }, Close)

  local Min = Custom:Create("TextButton", {
    Font = Enum.Font.GothamBold,
    Text = "-",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 18,
    AnchorPoint = Vector2.new(1, 0.5),
    BackgroundColor3 = Color3.fromRGB(40, 40, 46),
    BackgroundTransparency = 0.25,
    BorderColor3 = Color3.fromRGB(0, 0, 0),
    BorderSizePixel = 0,
    Position = UDim2.new(1, -42, 0.5, 0),
    Size = UDim2.new(0, 26, 0, 22),
    Name = "Min"
}, Top)
  Custom:Create("UICorner", { CornerRadius = UDim.new(0, 8) }, Min)
  Custom:Create("UIStroke", { Color = Color3.fromRGB(70,70,76), Thickness = 1, Transparency = 0.4 }, Min)

  local LayersTab = Custom:Create("Frame", {
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 0.9990000128746033,
    BorderColor3 = Color3.fromRGB(0, 0, 0),
    BorderSizePixel = 0,
    Position = UDim2.new(0, 9, 0, 50),
    Size = UDim2.new(0, TabWidth, 1, -59),
    Name = "LayersTab"
  }, Main)

  LayersTab.BackgroundColor3 = Color3.fromRGB(16, 16, 20)
  LayersTab.BackgroundTransparency = 0.2
  Custom:Create("UICorner", {
    CornerRadius = UDim.new(0, 12)
  }, LayersTab)
  Custom:Create("UIStroke", { Color = Color3.fromRGB(40,40,46), Thickness = 1, Transparency = 0.4 }, LayersTab)

  -- Search bar at top of tab list
  local TabSearch = Custom:Create("Frame", {
    BackgroundColor3 = Color3.fromRGB(28, 28, 34),
    BackgroundTransparency = 0.1,
    BorderSizePixel = 0,
    Position = UDim2.new(0, 6, 0, 6),
    Size = UDim2.new(1, -12, 0, 28),
    Name = "TabSearch"
  }, LayersTab)
  Custom:Create("UICorner", { CornerRadius = UDim.new(0, 8) }, TabSearch)
  Custom:Create("UIStroke", { Color = Color3.fromRGB(60,60,66), Thickness = 1, Transparency = 0.5 }, TabSearch)
  Custom:Create("ImageLabel", {
    Image = (LucideIcons["lucide-search"] or ""),
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 8, 0.5, -7),
    Size = UDim2.new(0, 14, 0, 14),
    ImageColor3 = Color3.fromRGB(180,180,180),
    Name = "Icon"
  }, TabSearch)
  local TabSearchBox = Custom:Create("TextBox", {
    Font = Enum.Font.Gotham,
    PlaceholderText = "Search",
    Text = "",
    PlaceholderColor3 = Color3.fromRGB(140,140,140),
    TextColor3 = Color3.fromRGB(235,235,235),
    TextSize = 12,
    TextXAlignment = Enum.TextXAlignment.Left,
    BackgroundTransparency = 1,
    Position = UDim2.new(0, 28, 0, 0),
    Size = UDim2.new(1, -34, 1, 0),
    ClearTextOnFocus = false,
    Name = "TabSearchBox"
  }, TabSearch)

  Custom:Create("Frame", {
    AnchorPoint = Vector2.new(0.5, 0),
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 0.85,
    BorderColor3 = Color3.fromRGB(0, 0, 0),
    BorderSizePixel = 0,
    Position = UDim2.new(0.5, 0, 0, 38),
    Size = UDim2.new(1, 0, 0, 1),
    Name = "DecideFrame"
  }, Main)

  local Layers = Custom:Create("Frame", {
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 0.9990000128746033,
    BorderColor3 = Color3.fromRGB(0, 0, 0),
    BorderSizePixel = 0,
    Position = UDim2.new(0, TabWidth + 18, 0, 50),
    Size = UDim2.new(1, -(TabWidth + 9 + 18), 1, -59),
    Name = "Layers"
  }, Main)

  Custom:Create("UICorner", {
    CornerRadius = UDim.new(0, 10)
  }, Layers)

  local NameTab = Custom:Create("TextLabel", {
    Font = Enum.Font.GothamBlack,
    Text = "",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextSize = 22,
    TextWrapped = true,
    TextXAlignment = Enum.TextXAlignment.Left,
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 0.9990000128746033,
    BorderColor3 = Color3.fromRGB(0, 0, 0),
    BorderSizePixel = 0,
    Size = UDim2.new(1, 0, 0, 30),
    Name = "NameTab"
  }, Layers)

  local LayersReal = Custom:Create("Frame", {
    AnchorPoint = Vector2.new(0, 1),
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 0.9990000128746033,
    BorderColor3 = Color3.fromRGB(0, 0, 0),
    BorderSizePixel = 0,
    ClipsDescendants = true,
    Position = UDim2.new(0, 0, 1, 0),
    Size = UDim2.new(1, 0, 1, -33),
    Name = "LayersReal"
  }, Layers)

  local LayersFolder = Custom:Create("Folder", {
    Name = "LayersFolder"
  }, LayersReal)

  local LayersPageLayout = Custom:Create("UIPageLayout", {
    SortOrder = Enum.SortOrder.LayoutOrder,
    Name = "LayersPageLayout",
    TweenTime = 0.5,
    EasingDirection = Enum.EasingDirection.InOut,
    EasingStyle = Enum.EasingStyle.Quad
  }, LayersFolder)

  local ScrollTab = Custom:Create("ScrollingFrame", {
    CanvasSize = UDim2.new(0, 0, 2.10000002, 0),
    ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0),
    ScrollBarThickness = 0,
    Active = true,
    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
    BackgroundTransparency = 0.9990000128746033,
    BorderColor3 = Color3.fromRGB(0, 0, 0),
    BorderSizePixel = 0,
    Position = UDim2.new(0, 0, 0, 40),
    Size = UDim2.new(1, 0, 1, -50),
    Name = "ScrollTab"
  }, LayersTab)

  local UIListLayout = Custom:Create("UIListLayout", {
    Padding = UDim.new(0, 0),
    SortOrder = Enum.SortOrder.LayoutOrder
  }, ScrollTab)

  local function UpdateSize()
    local _Total = 0

		for _, v in pairs(ScrollTab:GetChildren()) do
			if v.Name ~= "UIListLayout" then
				_Total = _Total + 3 + v.Size.Y.Offset
			end
		end

		ScrollTab.CanvasSize = UDim2.new(0, 0, 0, _Total)
  end

  ScrollTab.ChildAdded:Connect(UpdateSize)
  ScrollTab.ChildRemoved:Connect(UpdateSize)

  TabSearchBox:GetPropertyChangedSignal("Text"):Connect(function()
    local q = string.lower(TabSearchBox.Text)
    for _, t in pairs(ScrollTab:GetChildren()) do
      if t:IsA("Frame") and t.Name == "Tab" then
        local nm = t:FindFirstChild("TabName")
        if nm then
          t.Visible = q == "" or string.find(string.lower(nm.Text), q, 1, true) ~= nil
        end
      end
    end
    UpdateSize()
  end)

  Min.Activated:Connect(function()
		CircleClick(Min, Player:GetMouse().X, Player:GetMouse().Y)
		DropShadowHolder.Visible = false

		if not Open_Close.Visible then Open_Close.Visible = true end
	end)

  Open_Close.Activated:Connect(function()
		DropShadowHolder.Visible = true
		if Open_Close.Visible then Open_Close.Visible = false end
	end)

  Close.Activated:Connect(function()
		CircleClick(Close, Player:GetMouse().X, Player:GetMouse().Y)
    if SpeedHubXGui then SpeedHubXGui:Destroy() end
		if not Speed_Library.Unloaded then Speed_Library.Unloaded = true end
	end)

  DropShadowHolder.Size = UDim2.new(0, 115 + TextLabel.TextBounds.X + 1 + TextLabel1.TextBounds.X, 0, 350)
	MakeDraggable(Top, DropShadowHolder)


  -- /// Blur

  local MoreBlur = Custom:Create("Frame", {
    AnchorPoint = Vector2.new(1, 1),
    BackgroundColor3 = Color3.fromRGB(0, 0, 0),
    BackgroundTransparency = 1,
    BorderColor3 = Color3.fromRGB(0, 0, 0),
    BorderSizePixel = 0,
    ClipsDescendants = true,
    Position = UDim2.new(1, 8, 1, 8),
    Size = UDim2.new(1, 154, 1, 54),
    Visible = false,
    Name = "MoreBlur"
  }, Layers)

  local DropShadowHolder1 = Custom:Create("Frame", {
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Size = UDim2.new(1, 0, 1, 0),
    ZIndex = 0,
    Name = "DropShadowHolder"
  }, MoreBlur)

  local DropShadow1 = Custom:Create("ImageLabel", {
    Image = "",
    ImageColor3 = Color3.fromRGB(0, 0, 0),
    ImageTransparency = 0.5,
    ScaleType = Enum.ScaleType.Slice,
    SliceCenter = Rect.new(49, 49, 450, 450),
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Position = UDim2.new(0.5, 0, 0.5, 0),
    Size = UDim2.new(1, 35, 1, 35),
    ZIndex = 0,
    Name = "DropShadow"
  }, DropShadowHolder1)

  Custom:Create("UICorner", {}, MoreBlur)

  local ConnectButton = Custom:Create("TextButton", {
		Font = Enum.Font.GothamBold,
		Text = "",
		TextColor3 = Color3.fromRGB(0, 0, 0),
		TextSize = 14,
		BackgroundColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundTransparency = 0.999,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 1, 0),
		Name = "ConnectButton",
	}, MoreBlur)

  local DropdownSelect = Custom:Create("Frame", {
    AnchorPoint = Vector2.new(1, 0.5),
    BackgroundColor3 = Color3.fromRGB(30, 30, 30),
    BorderColor3 = Color3.fromRGB(0, 0, 0),
    BorderSizePixel = 0,
    LayoutOrder = 1,
    Position = UDim2.new(1, 172, 0.5, 0),
    Size = UDim2.new(0, 160, 1, -16),
    Name = "DropdownSelect",
    ClipsDescendants = true,
  }, MoreBlur)

  ConnectButton.Activated:Connect(function()
    if MoreBlur.Visible then
      local tweenInfo = TweenInfo.new(0.2)

      local _Hide = TweenService:Create(MoreBlur, tweenInfo, {BackgroundTransparency = 0.999})
      local _Move = TweenService:Create(DropdownSelect, tweenInfo, {Position = UDim2.new(1, 172, 0.5, 0)})

      _Hide:Play()
      _Move:Play()
        
      task.wait(0.2)
      MoreBlur.Visible = false
    end
  end)

  Custom:Create("UICorner", {
    CornerRadius = UDim.new(0, 8),
    Parent = DropdownSelect
  })

  Custom:Create("UIStroke", {
    Color = Color3.fromRGB(255, 255, 255),
    Thickness = 2.5,
    Transparency = 0.8,
    Parent = DropdownSelect
  })

  local DropdownSelectReal = Custom:Create("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Color3.fromRGB(0, 0, 0),
		BackgroundTransparency = 0.999,
		BorderColor3 = Color3.fromRGB(0, 0, 0),
		BorderSizePixel = 0,
		LayoutOrder = 1,
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.new(1, -10, 1, -10),
		Name = "DropdownSelectReal",
		Parent = DropdownSelect
	})

  local DropdownFolder = Custom:Create("Folder", {
		Name = "DropdownFolder",
		Parent = DropdownSelectReal
	})

  local DropPageLayout = Custom:Create("UIPageLayout", {
    EasingDirection = Enum.EasingDirection.InOut,
    EasingStyle = Enum.EasingStyle.Quad,
    TweenTime = 0.01,
    SortOrder = Enum.SortOrder.LayoutOrder,
    Archivable = false,
    Name = "DropPageLayout",
    Parent = DropdownFolder
  })

  -- /// Create Tab

  local Tabs = {}
  local CountTab = 0
  local CountDropdown = 0
  function Tabs:CreateTab(Config)
    local _Name = Config[1] or Config.Name or "" 
    local Icon = Config[2] or Config.Icon or ""
    
    local ScrolLayers = Custom:Create("ScrollingFrame", {
			ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80),
			ScrollBarThickness = 0,
			Active = true,
			LayoutOrder = CountTab,
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundTransparency = 0.999,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			Size = UDim2.new(1, 0, 1, 0),
			Name = "ScrolLayers",
			Parent = LayersFolder
		})

    Custom:Create("UIListLayout", {
      Padding = UDim.new(0, 3),
      SortOrder = Enum.SortOrder.LayoutOrder,
      Parent = ScrolLayers
    })

    local Tab = Custom:Create("Frame", {
			BackgroundColor3 = Custom.ColorRGB,
			BackgroundTransparency = CountTab == 0 and 0.7 or 0.999,
			BorderColor3 = Color3.fromRGB(0, 0, 0),
			BorderSizePixel = 0,
			LayoutOrder = CountTab,
			Size = UDim2.new(1, 0, 0, 32),
			Name = "Tab",
			Parent = ScrollTab
		})

    Custom:Create("UICorner", {
      CornerRadius = UDim.new(0, 10),
      Parent = Tab
    })

    local TabButton = Custom:Create("TextButton", {
      Font = Enum.Font.GothamBold,
      Text = "",
      TextColor3 = Color3.fromRGB(255, 255, 255),
      TextSize = 13,
      TextXAlignment = Enum.TextXAlignment.Left,
      BackgroundColor3 = Color3.fromRGB(255, 255, 255),
      BackgroundTransparency = 0.999,
      BorderColor3 = Color3.fromRGB(0, 0, 0),
      BorderSizePixel = 0,
      Size = UDim2.new(1, 0, 1, 0),
      Name = "TabButton",
    }, Tab)

    Custom:Create("TextLabel", {
      Font = Enum.Font.GothamBold,
      Text = _Name,
      TextColor3 = Color3.fromRGB(255, 255, 255),
      TextSize = 13,
      TextXAlignment = Enum.TextXAlignment.Left,
      BackgroundColor3 = Color3.fromRGB(255, 255, 255),
      BackgroundTransparency = 0.999,
      BorderColor3 = Color3.fromRGB(0, 0, 0),
      BorderSizePixel = 0,
      Size = UDim2.new(1, 0, 1, 0),
      Position = UDim2.new(0, 30, 0, 0),
      Name = "TabName",
    }, Tab)

    Custom:Create("ImageLabel", {
      Image = Icon,
      BackgroundColor3 = Color3.fromRGB(255, 255, 255),
      BackgroundTransparency = 0.999,
      BorderColor3 = Color3.fromRGB(0, 0, 0),
      BorderSizePixel = 0,
      Position = UDim2.new(0, 9, 0, 7),
      Size = UDim2.new(0, 16, 0, 16),
      Name = "FeatureImg",
    }, Tab)

    if CountTab == 0 then
      LayersPageLayout:JumpToIndex(0)
      NameTab.Text = _Name
  
      local ChooseFrame = Custom:Create("Frame", {
        BackgroundColor3 = Custom.ColorRGB,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 2, 0, 9),
        Size = UDim2.new(0, 0, 0, 12),
        Name = "ChooseFrame",
        Visible = false,
      }, Tab)
  
      Custom:Create("UIStroke", {
        Color = Custom.ColorRGB,
        Thickness = 1.6,
      }, ChooseFrame)
  
      Custom:Create("UICorner", {}, ChooseFrame)
    end

    TabButton.Activated:Connect(function()
      CircleClick(TabButton, Player:GetMouse().X, Player:GetMouse().Y)
      local FrameChoose = nil

      for _, s in pairs(ScrollTab:GetChildren()) do
        for _, v in pairs(s:GetChildren()) do
          if v.Name == "ChooseFrame" then
            FrameChoose = v
            break
          end
        end

        if FrameChoose then break end
      end
  
      if FrameChoose and Tab.LayoutOrder ~= LayersPageLayout.CurrentPage.LayoutOrder then
        for _, TabFrame in pairs(ScrollTab:GetChildren()) do
          if TabFrame.Name == "Tab" then
            TweenService:Create(TabFrame, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.InOut), {BackgroundTransparency = 0.999, BackgroundColor3 = Custom.ColorRGB}):Play()
          end
        end
  
        local _TabT = TweenService:Create(Tab, TweenInfo.new(0.6, Enum.EasingStyle.Back, Enum.EasingDirection.InOut), {BackgroundTransparency = 0.7, BackgroundColor3 = Custom.ColorRGB})
        local _FTween = TweenService:Create(FrameChoose, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), { Position = UDim2.new(0, 2, 0, 9 + (33 * Tab.LayoutOrder)) })

        _TabT:Play()
        _FTween:Play()
  
        LayersPageLayout:JumpToIndex(Tab.LayoutOrder)
  
        task.wait(0.05)
        NameTab.Text = _Name
  
        TweenService:Create(FrameChoose, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Size = UDim2.new(0, 1, 0, 20)}):Play()
  
        task.wait(0.2)
        TweenService:Create(FrameChoose, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {Size = UDim2.new(0, 1, 0, 12)}):Play()
      end
    end)

    --- /// Section
   
    local Sections, CountSection = {}, 0

    function Sections:AddSection(Title, OpenSection)
      local Title = Title or ""
      local OpenSection = OpenSection or false
  
      local Section = Custom:Create("Frame", {
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 0.999,
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        ClipsDescendants = true,
        LayoutOrder = CountSection,
        Size = UDim2.new(1, 0, 0, 30),
        Name = "Section"
      }, ScrolLayers)
  
      local SectionReal = Custom:Create("Frame", {
        AnchorPoint = Vector2.new(0.5, 0),
        BackgroundColor3 = Custom.ColorRGB,
        BackgroundTransparency = 0.82,
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        LayoutOrder = 1,
        Position = UDim2.new(0.5, 0, 0, 0),
        Size = UDim2.new(1, 1, 0, 30),
        Name = "SectionReal"
      }, Section)
  
      Custom:Create("UICorner", {
        CornerRadius = UDim.new(0, 10)
      }, SectionReal)
  
      local SectionButton = Custom:Create("TextButton", {
        Font = Enum.Font.GothamBold,
        Text = "",
        TextColor3 = Color3.fromRGB(0, 0, 0),
        TextSize = 14,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 0.9990000128746033,
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 1, 0),
        Name = "SectionButton"
      }, SectionReal)
  
      local FeatureFrame = Custom:Create("Frame", {
        AnchorPoint = Vector2.new(1, 0.5),
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        BackgroundTransparency = 0.9990000128746033,
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        Position = UDim2.new(1, -5, 0.5, 0),
        Size = UDim2.new(0, 20, 0, 20),
        Name = "FeatureFrame"
      }, SectionReal)
  
      local FeatureImg = Custom:Create("ImageLabel", {
        Image = "rbxassetid://125609963478878",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 0.9990000128746033,
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        Position = UDim2.new(0.5, 0, 0.5, 0),
        Rotation = -90,
        Size = UDim2.new(1, 6, 1, 6),
        Name = "FeatureImg"
      }, FeatureFrame)
  
      local SectionTitle = Custom:Create("TextLabel", {
        Font = Enum.Font.GothamBold,
        Text = Title,
        TextColor3 = Color3.fromRGB(245, 245, 245),
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
        AnchorPoint = Vector2.new(0, 0.5),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 0.9990000128746033,
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        Position = UDim2.new(0, 10, 0.5, 0),
        Size = UDim2.new(1, -50, 0, 13),
        Name = "SectionTitle"
      }, SectionReal)
  
      local SectionDecideFrame = Custom:Create("Frame", {
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.new(0.5, 0, 0, 33),
        Size = UDim2.new(0, 0, 0, 2),
        Name = "SectionDecideFrame"
      }, Section)
      Custom:Create("UICorner", {}, SectionDecideFrame)
      Custom:Create("UIGradient", {
        Color = ColorSequence.new{
          ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 20)),
          ColorSequenceKeypoint.new(0.5, Custom.ColorRGB),
          ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 20))
        }
      }, SectionDecideFrame)
  
      local SectionAdd = Custom:Create("Frame", {
        AnchorPoint = Vector2.new(0.5, 0),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 0.9990000128746033,
        BorderColor3 = Color3.fromRGB(0, 0, 0),
        BorderSizePixel = 0,
        ClipsDescendants = true,
        LayoutOrder = 1,
        Position = UDim2.new(0.5, 0, 0, 38),
        Size = UDim2.new(1, 0, 0, 100),
        Name = "SectionAdd"
      }, Section)
      SectionAdd.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
      SectionAdd.BackgroundTransparency = 0.35
      Custom:Create("UICorner", {
        CornerRadius = UDim.new(0, 10)
      }, SectionAdd)
      Custom:Create("UIStroke", { Color = Color3.fromRGB(45,45,50), Thickness = 1, Transparency = 0.55 }, SectionAdd)
    
      Custom:Create("UIListLayout", {
        Padding = UDim.new(0, 3),
        SortOrder = Enum.SortOrder.LayoutOrder
      }, SectionAdd)
  
      local function UpdateSizeScroll()
        local OffsetY = 0
  
        for _, child in pairs(ScrolLayers:GetChildren()) do
          if child.Name ~= "UIListLayout" then
            OffsetY = OffsetY + 3 + child.Size.Y.Offset
          end
        end
        
        ScrolLayers.CanvasSize = UDim2.new(0, 0, 0, OffsetY)
      end
    
      local function UpdateSizeSection()
        if OpenSection then
          local SectionSizeYWitdh = 38
  
          for _, v in pairs(SectionAdd:GetChildren()) do
            if v.Name ~= "UIListLayout" and v.Name ~= "UICorner" then
              SectionSizeYWitdh = SectionSizeYWitdh + v.Size.Y.Offset + 3
            end
          end
    
          TweenService:Create(FeatureFrame, TweenInfo.new(0.1), {Rotation = 90}):Play()
          TweenService:Create(Section, TweenInfo.new(0.1), {Size = UDim2.new(1, 1, 0, SectionSizeYWitdh)}):Play()
          TweenService:Create(SectionAdd, TweenInfo.new(0.1), {Size = UDim2.new(1, 0, 0, SectionSizeYWitdh - 38)}):Play()
          TweenService:Create(SectionDecideFrame, TweenInfo.new(0.1), {Size = UDim2.new(1, 0, 0, 2)}):Play()
            
          task.wait(0.5)
          UpdateSizeScroll()
        end
      end
    
      local function ToggleSection()
        CircleClick(SectionButton, Player:GetMouse().X, Player:GetMouse().Y)
        
        if OpenSection then
          TweenService:Create(FeatureFrame, TweenInfo.new(0.1), {Rotation = 0}):Play()
          TweenService:Create(Section, TweenInfo.new(0.1), {Size = UDim2.new(1, 1, 0, 30)}):Play()
          TweenService:Create(SectionDecideFrame, TweenInfo.new(0.1), {Size = UDim2.new(0, 0, 0, 2)}):Play()
    
          OpenSection = false
          task.wait(0.1)
          UpdateSizeScroll()
        else
          OpenSection = true
          UpdateSizeSection()
        end
      end
    
      SectionButton.Activated:Connect(ToggleSection)
      SectionAdd.ChildAdded:Connect(UpdateSizeSection)
      SectionAdd.ChildRemoved:Connect(UpdateSizeSection)
    
      UpdateSizeScroll()

      local Item, ItemCount = {}, 0
      function Item:AddParagraph(Config)
        local Title = Config[1] or Config.Title or ""
        local Content = Config[2] or Config.Content or ""
        local SettingFuncs = {}

        local Paragraph = Custom:Create("Frame", {
          BackgroundColor3 = Color3.fromRGB(255, 255, 255),
          BackgroundTransparency = 0.935,
          BorderColor3 = Color3.fromRGB(0, 0, 0),
          BorderSizePixel = 0,
          LayoutOrder = ItemCount,
          Size = UDim2.new(1, 0, 0, 35),
          Name = "Paragraph",
        }, SectionAdd)
      
        Custom:Create("UICorner", {
          CornerRadius = UDim.new(0, 10),
        }, Paragraph)

        local ParagraphTitle = Custom:Create("TextLabel", {
          Font = Enum.Font.GothamBold,
          Text = Title,
          TextColor3 = Color3.fromRGB(231, 231, 231),
          TextSize = 13,
          TextXAlignment = Enum.TextXAlignment.Left,
          TextYAlignment = Enum.TextYAlignment.Top,
          BackgroundColor3 = Color3.fromRGB(255, 255, 255),
          BackgroundTransparency = 0.999,
          BorderSizePixel = 0,
          Position = UDim2.new(0, 10, 0, 10),
          Size = UDim2.new(1, -16, 0, 13),
          Name = "ParagraphTitle",
        }, Paragraph)
      
        local ParagraphContent = Custom:Create("TextLabel", {
          Font = Enum.Font.GothamBold,
          Text = Content,
          TextColor3 = Color3.fromRGB(255, 255, 255),
          TextSize = 12,
          TextTransparency = 0.6,
          TextXAlignment = Enum.TextXAlignment.Left,
          TextYAlignment = Enum.TextYAlignment.Bottom,
          BackgroundTransparency = 0.999,
          BorderSizePixel = 0,
          Position = UDim2.new(0, 10, 0, 23),
          Name = "ParagraphContent",
        }, Paragraph)

        local function UpdateParagraphSize()
          ParagraphContent.TextWrapped = false
          local lineCount = math.ceil(ParagraphContent.TextBounds.X / ParagraphContent.AbsoluteSize.X)

          ParagraphContent.Size = UDim2.new(1, -16, 0, 12 + (12 * lineCount))
          Paragraph.Size = UDim2.new(1, 0, 0, ParagraphContent.AbsoluteSize.Y + 33)
          ParagraphContent.TextWrapped = true

          UpdateSizeSection()
        end

        UpdateParagraphSize()

        ParagraphContent:GetPropertyChangedSignal("AbsoluteSize"):Connect(UpdateParagraphSize)

        function SettingFuncs:Set(Config)
          local Title = Config[1] or Config.Title or ""
          local Content = Config[2] or Config.Content or ""

          ParagraphTitle.Text = Title
          ParagraphContent.Text = Content

          UpdateParagraphSize()
        end

        return SettingFuncs
      end

      function Item:AddSeperator(Config)
        local Title = Config[1] or Config.Title or ""
        local Sep_Funcs = {}

        local Seperator = Custom:Create("Frame", {
          BackgroundColor3 = Color3.fromRGB(70, 70, 70),
          BackgroundTransparency = 0.1,
          BorderColor3 = Color3.fromRGB(0, 0, 0),
          BorderSizePixel = 1,
          LayoutOrder = ItemCount,
          Size = UDim2.new(1, 0, 0, 30),
          Name = "Seperator",
        }, SectionAdd)
      
        local SeperatorTitle = Custom:Create("TextLabel", {
          Font = Enum.Font.GothamBold,
          Text = Title,
          TextColor3 = Color3.fromRGB(231, 231, 231),
          TextStrokeColor3 = Color3.fromRGB(0, 0, 0),
          TextStrokeTransparency = 0.8,
          TextSize = 14,
          TextXAlignment = Enum.TextXAlignment.Left,
          TextYAlignment = Enum.TextYAlignment.Center,
          BackgroundColor3 = Color3.fromRGB(255, 255, 255),
          BackgroundTransparency = 1,
          BorderSizePixel = 0,
          Position = UDim2.new(0, 12, 0, 0),
          Size = UDim2.new(1, -16, 1, 0),
          Name = "SeperatorTitle",
        }, Seperator)
        
        Custom:Create("UICorner", {
          CornerRadius = UDim.new(0, 12),
        }, Seperator)
        
        local Gradient = Custom:Create("UIGradient", {
          Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(120, 120, 120)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(120, 120, 120))
          },
          Rotation = 90,
        }, Seperator)
  
        function Sep_Funcs:Set(Config)
          local Title = Config[1] or Config.Title or ""

          SeperatorTitle.Text = Title
        end

        ItemCount += 1
        return Sep_Funcs
      end

      function Item:AddLine()
        local LineFuncs = {}
    
        local Line = Custom:Create("Frame", {
          BackgroundColor3 = Color3.fromRGB(90, 90, 90),
          BackgroundTransparency = 0.2,
          BorderSizePixel = 0,
          LayoutOrder = ItemCount,
          Size = UDim2.new(1, 0, 0, 7),
          Name = "Line",
        }, SectionAdd)
    
        Custom:Create("UICorner", {CornerRadius = UDim.new(0, 8)}, Line)
    
        Custom:Create("UIGradient", {
          Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0, Color3.fromRGB(80, 80, 80)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(80, 80, 80))
          },
          Rotation = 0,
        }, Line)
    
        ItemCount += 1
        return LineFuncs
     end

      function Item:AddButton(Config)
        local Title = Config[1] or Config.Title or ""
        local Content = Config[2] or Config.Content or ""
        local Icon = Config[3] or Config.Icon or "rbxassetid://7734010488"
        local Callback = Config[4] or Config.Callback or function() end
        local Funcs_Button = {}

        local Button = Custom:Create("Frame", {
					Name = "Button",
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 0.935,
					BorderSizePixel = 0,
					LayoutOrder = ItemCount,
					Size = UDim2.new(1, 0, 0, 35)
				}, SectionAdd)

        Custom:Create("UICorner", {
          CornerRadius = UDim.new(0, 10)
        }, Button)

        Custom:Create("TextLabel", {
					Name = "ButtonTitle",
					Font = Enum.Font.GothamBold,
					Text = Title,
					TextColor3 = Color3.fromRGB(231, 231, 231),
					TextSize = 13,
					TextXAlignment = Enum.TextXAlignment.Left,
					TextYAlignment = Enum.TextYAlignment.Top,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 0.999,
					BorderSizePixel = 0,
					Position = UDim2.new(0, 10, 0, 10),
					Size = UDim2.new(1, -100, 0, 13)
				}, Button)

        local ButtonContent = Custom:Create("TextLabel", {
					Name = "ButtonContent",
					Font = Enum.Font.GothamBold,
					Text = Content,
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextSize = 12,
					TextTransparency = 0.6,
					TextXAlignment = Enum.TextXAlignment.Left,
					TextYAlignment = Enum.TextYAlignment.Bottom,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 0.999,
					BorderSizePixel = 0,
					Position = UDim2.new(0, 10, 0, 23),
					Size = UDim2.new(1, -100, 0, 12)
				}, Button)

        local function UpdateButtonSize()
          local _Height = 12 + (12 * (ButtonContent.TextBounds.X // ButtonContent.AbsoluteSize.X))
          ButtonContent.Size = UDim2.new(1, -100, 0, _Height)
          
          Button.Size = UDim2.new(1, 0, 0, ButtonContent.AbsoluteSize.Y + 33)
        end
      
        ButtonContent.TextWrapped = true
        UpdateButtonSize()
      
        ButtonContent:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
          ButtonContent.TextWrapped = false
          UpdateButtonSize()
          ButtonContent.TextWrapped = true
          UpdateSizeSection()
        end)

        local ButtonButton = Custom:Create("TextButton", {
					Name = "ButtonButton",
					Font = Enum.Font.GothamBold,
					Text = "",
					TextColor3 = Color3.fromRGB(0, 0, 0),
					TextSize = 14,
					BackgroundColor3 = Color3.fromRGB(0, 0, 0),
					BackgroundTransparency = 0.999,
					BorderSizePixel = 0,
					Size = UDim2.new(1, 0, 1, 0)
				}, Button)

        local FeatureFrame1 = Custom:Create("Frame", {
					Name = "FeatureFrame",
					AnchorPoint = Vector2.new(1, 0.5),
					BackgroundColor3 = Color3.fromRGB(0, 0, 0),
					BackgroundTransparency = 0.999,
					BorderSizePixel = 0,
					Position = UDim2.new(1, -15, 0.5, 0),
					Size = UDim2.new(0, 25, 0, 25)
				}, Button)

        Custom:Create("ImageLabel", {
          Name = "FeatureImg",
          Image = Icon,
          AnchorPoint = Vector2.new(0.5, 0.5),
          BackgroundColor3 = Color3.fromRGB(255, 255, 255),
          BackgroundTransparency = 0.999,
          BorderSizePixel = 0,
          Position = UDim2.new(0.5, 0, 0.5, 0),
          Size = UDim2.new(1, 0, 1, 0)
        }, FeatureFrame1)

        ButtonButton.Activated:Connect(function()
					CircleClick(ButtonButton, Player:GetMouse().X, Player:GetMouse().Y)

					Callback()
				end)

        ItemCount += 1
				return Funcs_Button
      end

      function Item:AddToggle(Config)
        local Title = Config[1] or Config.Title or ""
        local Content = Config[2] or Config.Content or ""
        local Default = Config[3] or Config.Default or false
        local Callback = Config[4] or Config.Callback or function() end

				local Funcs_Toggle = {Value = Default}

        local Toggle = Custom:Create("Frame", {
					Name = "Toggle",
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 0.935,
					BorderSizePixel = 0,
					LayoutOrder = ItemCount,
					Size = UDim2.new(1, 0, 0, 35)
				}, SectionAdd)

        Custom:Create("UICorner", {
          CornerRadius = UDim.new(0, 10)
        }, Toggle)

        local ToggleTitle = Custom:Create("TextLabel", {
					Name = "ToggleTitle",
					Font = Enum.Font.GothamBold,
					Text = Title,
					TextSize = 13,
					TextColor3 = Color3.fromRGB(231, 231, 231),
					TextXAlignment = Enum.TextXAlignment.Left,
					TextYAlignment = Enum.TextYAlignment.Top,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 0.999,
					BorderSizePixel = 0,
					Position = UDim2.new(0, 10, 0, 10),
					Size = UDim2.new(1, -100, 0, 13)
				}, Toggle)

        local ToggleContent = Custom:Create("TextLabel", {
					Name = "ToggleContent",
					Font = Enum.Font.GothamBold,
					Text = Content,
					TextSize = 12,
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextTransparency = 0.6,
					TextXAlignment = Enum.TextXAlignment.Left,
					TextYAlignment = Enum.TextYAlignment.Bottom,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 0.999,
					BorderSizePixel = 0,
					Position = UDim2.new(0, 10, 0, 23),
					Size = UDim2.new(1, -100, 0, 12)
				}, Toggle)
				
        local function UpdateToggleSize()
          ToggleContent.TextWrapped = false
          local Ratio = ToggleContent.TextBounds.X / ToggleContent.AbsoluteSize.X

          ToggleContent.Size = UDim2.new(1, -100, 0, 12 + (12 * math.ceil(Ratio)))
          Toggle.Size = UDim2.new(1, 0, 0, ToggleContent.AbsoluteSize.Y + 33)
          ToggleContent.TextWrapped = true
        end
      
        UpdateToggleSize()
      
        ToggleContent:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
          UpdateToggleSize()
          UpdateSizeSection()
        end)

        local ToggleButton = Custom:Create("TextButton", {
          Name = "ToggleButton",
          Font = Enum.Font.GothamBold,
          Text = "",
          TextColor3 = Color3.fromRGB(0, 0, 0),
          TextSize = 14,
          BackgroundColor3 = Color3.fromRGB(0, 0, 0),
          BackgroundTransparency = 0.999,
          BorderSizePixel = 0,
          Size = UDim2.new(1, 0, 1, 0)
        }, Toggle)

        
				local FeatureFrame2 = Custom:Create("Frame", {
					Name = "FeatureFrame2",
					AnchorPoint = Vector2.new(1, 0.5),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 0.92,
					BorderSizePixel = 0,
					Position = UDim2.new(1, -15, 0.5, 0),
					Size = UDim2.new(0, 30, 0, 15)
				}, Toggle)

        Custom:Create("UICorner", {
          CornerRadius = UDim.new(0, 10)
        }, FeatureFrame2)
      
        local UIStroke8 = Custom:Create("UIStroke", {
          Color = Color3.fromRGB(255, 255, 255),
          Thickness = 2,
          Transparency = 0.9
        }, FeatureFrame2)

        local ToggleCircle = Custom:Create("Frame", {
					Name = "ToggleCircle",
					BackgroundColor3 = Color3.fromRGB(230, 230, 230),
					BorderSizePixel = 0,
					Size = UDim2.new(0, 14, 0, 14),
					Position = UDim2.new(0, 0, 0, 0)
				}, FeatureFrame2)

        Custom:Create("UICorner", {
          CornerRadius = UDim.new(0, 15)
        }, ToggleCircle)

        local function ToggleAnimation(isOn)          
          local TitleColor = isOn and Custom.ColorRGB or Color3.fromRGB(230, 230, 230)
          local CirclePosition = isOn and UDim2.new(0, 15, 0, 0) or UDim2.new(0, 0, 0, 0)
          local StrokeColor = isOn and Custom.ColorRGB or Color3.fromRGB(255, 255, 255)
          local StrokeTransparency = isOn and 0 or 0.9
          local FrameColor = isOn and Custom.ColorRGB or Color3.fromRGB(255, 255, 255)
          local FrameTransparency = isOn and 0 or 0.92

          local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
      
          TweenService:Create(ToggleTitle, tweenInfo, {TextColor3 = TitleColor}):Play()
          TweenService:Create(ToggleCircle, tweenInfo, {Position = CirclePosition}):Play()
          TweenService:Create(UIStroke8, tweenInfo, {Color = StrokeColor, Transparency = StrokeTransparency}):Play()
          TweenService:Create(FeatureFrame2, tweenInfo, {BackgroundColor3 = FrameColor, BackgroundTransparency = FrameTransparency}):Play()
        end
      
        ToggleButton.Activated:Connect(function()
          CircleClick(ToggleButton, Player:GetMouse().X, Player:GetMouse().Y)
          Funcs_Toggle.Value = not Funcs_Toggle.Value
          Funcs_Toggle:Set(Funcs_Toggle.Value)
        end)
      
        function Funcs_Toggle:Set(Value)
          Callback(Value)
          ToggleAnimation(Value)
        end
        Funcs_Toggle:Set(Funcs_Toggle.Value)

        ItemCount += 1
				return Funcs_Toggle
      end

      function Item:AddSlider(Config)
        local Title = Config[1] or Config.Title or ""
        local Content = Config[2] or Config.Content or ""
        local Increment = Config[3] or Config.Increment or 1
        local Min = Config[4] or Config.Min or 0
        local Max = Config[5] or Config.Max or 100
        local Default = Config[6] or Config.Default or 50
        local Callback = Config[7] or Config.Callback or function() end

				local Funcs_Slider = {Value = Default}
        
        local Slider = Custom:Create("Frame", {
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 0.9350000023841858,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					LayoutOrder = ItemCount,
					Size = UDim2.new(1, 0, 0, 35),
					Name = "Slider",
				}, SectionAdd)

        Custom:Create("UICorner", {
          CornerRadius = UDim.new(0, 10),
        }, Slider)

        Custom:Create("TextLabel", {
					Font = Enum.Font.GothamBold,
					Text = Title,
					TextColor3 = Color3.fromRGB(230, 230, 230),
					TextSize = 13,
					TextXAlignment = Enum.TextXAlignment.Left,
					TextYAlignment = Enum.TextYAlignment.Top,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 0.9990000128746033,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.new(0, 10, 0, 10),
					Size = UDim2.new(1, -180, 0, 13),
					Name = "SliderTitle",
				}, Slider)

				local SliderContent = Custom:Create("TextLabel", {
					Font = Enum.Font.GothamBold,
					Text = Content,
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextSize = 12,
					TextTransparency = 0.6000000238418579,
					TextXAlignment = Enum.TextXAlignment.Left,
					TextYAlignment = Enum.TextYAlignment.Bottom,
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 0.9990000128746033,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.new(0, 10, 0, 23),
					Size = UDim2.new(1, -180, 0, 12),
					Name = "SliderContent",
				}, Slider)

        local function UpdateSliderSize()
          SliderContent.TextWrapped = false
          SliderContent.Size = UDim2.new(1, -180, 0, 12 + (12 * math.floor(SliderContent.TextBounds.X / SliderContent.AbsoluteSize.X)))
          Slider.Size = UDim2.new(1, 0, 0, SliderContent.AbsoluteSize.Y + 33)
          SliderContent.TextWrapped = true
        end

        SliderContent:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
          UpdateSliderSize()
          UpdateSizeSection()
        end)
        UpdateSliderSize()

        local SliderInput = Custom:Create("Frame", {
					AnchorPoint = Vector2.new(0, 0.5),
					BackgroundColor3 = Custom.ColorRGB,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.new(1, -155, 0.5, 0),
					Size = UDim2.new(0, 28, 0, 20),
					Name = "SliderInput",
				}, Slider)

        Custom:Create("UICorner", {
          CornerRadius = UDim.new(0, 10),
        }, SliderInput)

         
				local TextBox = Custom:Create("TextBox", {
					Font = Enum.Font.GothamBold,
					Text = "90",
					TextColor3 = Color3.fromRGB(255, 255, 255),
					TextSize = 13,
					TextWrapped = true,
					BackgroundColor3 = Color3.fromRGB(0, 0, 0),
					BackgroundTransparency = 0.9990000128746033,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.new(0, -1, 0, 0),
					Size = UDim2.new(1, 0, 1, 0),
				}, SliderInput)

        local SliderFrame = Custom:Create("Frame", {
					AnchorPoint = Vector2.new(1, 0.5),
					BackgroundColor3 = Color3.fromRGB(255, 255, 255),
					BackgroundTransparency = 0.800000011920929,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.new(1, -20, 0.5, 0),
					Size = UDim2.new(0, 100, 0, 3),
					Name = "SliderFrame",
				}, Slider)

        Custom:Create("UICorner", {}, SliderFrame)

        local SliderDraggable = Custom:Create("Frame", {
					AnchorPoint = Vector2.new(0, 0.5),
					BackgroundColor3 = Custom.ColorRGB,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.new(0, 0, 0.5, 0),
					Size = UDim2.new(0.899999976, 0, 0, 1),
					Name = "SliderDraggable",
				}, SliderFrame)

        Custom:Create("UICorner", {}, SliderDraggable)

        local SliderCircle = Custom:Create("Frame", {
					AnchorPoint = Vector2.new(1, 0.5),
					BackgroundColor3 = Custom.ColorRGB,
					BorderColor3 = Color3.fromRGB(0, 0, 0),
					BorderSizePixel = 0,
					Position = UDim2.new(1, 4, 0.5, 0),
					Size = UDim2.new(0, 8, 0, 8),
					Name = "SliderCircle",
				}, SliderDraggable)

        Custom:Create("UICorner", {}, SliderCircle)

        Custom:Create("UIStroke", {
          Color = Custom.ColorRGB,
        }, SliderCircle)

        local Dragging = false

        local function Round(Number, Factor)
          local Result = math.floor(Number / Factor + (math.sign(Number) * 0.5)) * Factor
          if Result < 0 then 
            Result = Result + Factor 
          end
          return Result
        end
        
        function Funcs_Slider:Set(Value)
          Value = math.clamp(Round(Value, Increment), Min, Max)
          Funcs_Slider.Value = Value
          TextBox.Text = tostring(Value)
            
          TweenService:Create(SliderDraggable, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Size = UDim2.fromScale((Value - Min) / (Max - Min), 1) }):Play()
        end
        
        SliderFrame.InputBegan:Connect(function(Input)
          if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
            Dragging = true
          end
        end)
      
        SliderFrame.InputEnded:Connect(function(Input)
          if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
            Dragging = false
            Callback(Funcs_Slider.Value)
          end
        end)
      
        local _LastX = nil
        UserInputService.InputChanged:Connect(function(Input)
          if Dragging then
            local CurrPosX = Input.Position.X
            if CurrPosX ~= _LastX then
              _LastX = CurrPosX
      
              local SizeScale = math.clamp((CurrPosX - SliderFrame.AbsolutePosition.X) / SliderFrame.AbsoluteSize.X, 0, 1)
              Funcs_Slider:Set(Min + ((Max - Min) * SizeScale))
            end
          end
        end)
        
        TextBox:GetPropertyChangedSignal("Text"):Connect(function()
          local Valid = TextBox.Text:gsub("[^%d]", "")
          if Valid ~= "" then
            local ValidNumber = math.min(tonumber(Valid), Max)
            TextBox.Text = tostring(ValidNumber)
          else
            TextBox.Text = "0"
          end
        end)
        
        TextBox.FocusLost:Connect(function()
          if TextBox.Text ~= "" then
            Funcs_Slider:Set(tonumber(TextBox.Text))
            Callback(Funcs_Slider.Value)
          else
            Funcs_Slider:Set(0)
            Callback(Funcs_Slider.Value)
          end
        end)
        
        Funcs_Slider:Set(tonumber(Default))
        Callback(Funcs_Slider.Value)

        ItemCount += 1
				return Funcs_Slider
      end

      function Item:AddInput(Config)
        local Title = Config[1] or Config.Title or ""
        local Content = Config[2] or Config.Content or ""
        local Default = Config[3] or Config.Default or ""
        local Callback = Config[4] or Config.Callback or function() end
				local Funcs_Input = {Value = Default}

        local Input = Custom:Create("Frame", {
          BackgroundColor3 = Color3.fromRGB(255, 255, 255),
          BackgroundTransparency = 0.935,
          BorderColor3 = Color3.fromRGB(0, 0, 0),
          BorderSizePixel = 0,
          LayoutOrder = ItemCount,
          Size = UDim2.new(1, 0, 0, 35),
          Name = "Input",
        }, SectionAdd)

        Custom:Create("UICorner", {
          CornerRadius = UDim.new(0, 10),
        }, Input)

        local InputTitle = Custom:Create("TextLabel", {
          Font = Enum.Font.GothamBold,
          Text = Title,
          TextColor3 = Color3.fromRGB(230, 230, 230),
          TextSize = 13,
          TextXAlignment = Enum.TextXAlignment.Left,
          TextYAlignment = Enum.TextYAlignment.Top,
          BackgroundColor3 = Color3.fromRGB(255, 255, 255),
          BackgroundTransparency = 0.999,
          BorderColor3 = Color3.fromRGB(0, 0, 0),
          BorderSizePixel = 0,
          Position = UDim2.new(0, 10, 0, 10),
          Size = UDim2.new(1, -180, 0, 13),
          Name = "InputTitle",
        }, Input)

        local InputContent = Custom:Create("TextLabel", {
          Font = Enum.Font.GothamBold,
          Text = Content,
          TextColor3 = Color3.fromRGB(255, 255, 255),
          TextSize = 12,
          TextTransparency = 0.6,
          TextWrapped = true,
          TextXAlignment = Enum.TextXAlignment.Left,
          TextYAlignment = Enum.TextYAlignment.Bottom,
          BackgroundColor3 = Color3.fromRGB(255, 255, 255),
          BackgroundTransparency = 0.999,
          BorderColor3 = Color3.fromRGB(0, 0, 0),
          BorderSizePixel = 0,
          Position = UDim2.new(0, 10, 0, 23),
          Size = UDim2.new(1, -180, 0, 12),
          Name = "InputContent",
          Parent = Input
        })

        local function UpdateInputSize()
          local Ratio = InputContent.TextBounds.X / InputContent.AbsoluteSize.X
          local Calculated = 12 + (12 * math.floor(Ratio))

          InputContent.Size = UDim2.new(1, -180, 0, Calculated)
          Input.Size = UDim2.new(1, 0, 0, InputContent.AbsoluteSize.Y + 33)
        end
      
        UpdateInputSize()
      
        InputContent:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
          InputContent.TextWrapped = false
          UpdateInputSize()
          InputContent.TextWrapped = true
          UpdateSizeSection()
        end)

        local InputFrame = Custom:Create("Frame", {
          AnchorPoint = Vector2.new(1, 0.5),
          BackgroundColor3 = Color3.fromRGB(255, 255, 255),
          BackgroundTransparency = 0.95,
          BorderColor3 = Color3.fromRGB(0, 0, 0),
          BorderSizePixel = 0,
          ClipsDescendants = true,
          Position = UDim2.new(1, -7, 0.5, 0),
          Size = UDim2.new(0, 148, 0, 30),
          Name = "InputFrame"
        }, Input)
    

        Custom:Create("UICorner", {
          CornerRadius = UDim.new(0, 10)
        }, InputFrame)

        local InputTextBox = Custom:Create("TextBox", {
          CursorPosition = -1,
          Font = Enum.Font.GothamBold,
          PlaceholderColor3 = Color3.fromRGB(120, 120, 120),
          PlaceholderText = "Write your input there",
          Text = "",
          TextColor3 = Color3.fromRGB(255, 255, 255),
          TextSize = 12,
          TextXAlignment = Enum.TextXAlignment.Left,
          AnchorPoint = Vector2.new(0, 0.5),
          BackgroundColor3 = Color3.fromRGB(255, 255, 255),
          BackgroundTransparency = 0.999,
          BorderColor3 = Color3.fromRGB(0, 0, 0),
          BorderSizePixel = 0,
          Position = UDim2.new(0, 5, 0.5, 0),
          Size = UDim2.new(1, -10, 1, -8),
          Name = "InputTextBox"
        }, InputFrame)

        function Funcs_Input:Set(Value)
					InputTextBox.Text = Value
					Funcs_Input.Value = Value
					Callback(Value)
				end

				InputTextBox.FocusLost:Connect(function()
					Funcs_Input:Set(InputTextBox.Text)
				end)

				Funcs_Input:Set(Default)

        ItemCount += 1
				return Funcs_Input
      end

      function Item:AddDropdown(Config)
        local Title = Config[1] or Config.Title or ""
        local Content = Config[2] or Config.Content or ""
        local Multi = Config[3] or Config.Multi or false
        local Options = Config[4] or Config.Options or {}
        local Default = Config[5] or Config.Default or {}
        local Callback = Config[6] or Config.Callback or function() end

        local Funcs_Dropdown = {Value = Default, Options = Options}

        local Dropdown = Custom:Create("Frame", {
          BackgroundColor3 = Color3.fromRGB(255, 255, 255),
          BackgroundTransparency = 0.935,
          BorderColor3 = Color3.fromRGB(0, 0, 0),
          BorderSizePixel = 0,
          LayoutOrder = ItemCount,
          Size = UDim2.new(1, 0, 0, 35),
          Name = "Dropdown"
        }, SectionAdd)

        local DropdownButton = Custom:Create("TextButton", {
          Font = Enum.Font.GothamBold,
          Text = "",
          TextColor3 = Color3.fromRGB(0, 0, 0),
          TextSize = 14,
          BackgroundColor3 = Color3.fromRGB(0, 0, 0),
          BackgroundTransparency = 0.999,
          BorderColor3 = Color3.fromRGB(0, 0, 0),
          BorderSizePixel = 0,
          Size = UDim2.new(1, 0, 1, 0),
          Name = "ToggleButton"
        }, Dropdown)

        Custom:Create("UICorner", {
          CornerRadius = UDim.new(0, 10)
        }, Dropdown)

        local DropdownTitle = Custom:Create("TextLabel", {
          Font = Enum.Font.GothamBold,
          Text = Title,
          TextColor3 = Color3.fromRGB(230, 230, 230),
          TextSize = 13,
          TextXAlignment = Enum.TextXAlignment.Left,
          TextYAlignment = Enum.TextYAlignment.Top,
          BackgroundColor3 = Color3.fromRGB(255, 255, 255),
          BackgroundTransparency = 0.999,
          BorderColor3 = Color3.fromRGB(0, 0, 0),
          BorderSizePixel = 0,
          Position = UDim2.new(0, 10, 0, 10),
          Size = UDim2.new(1, -180, 0, 13),
          Name = "DropdownTitle",
          Parent = Dropdown
        })

        local DropdownContent = Custom:Create("TextLabel", {
          Font = Enum.Font.GothamBold,
          Text = Content,
          TextColor3 = Color3.fromRGB(255, 255, 255),
          TextSize = 12,
          TextTransparency = 0.6,
          TextWrapped = true,
          TextXAlignment = Enum.TextXAlignment.Left,
          TextYAlignment = Enum.TextYAlignment.Bottom,
          BackgroundColor3 = Color3.fromRGB(255, 255, 255),
          BackgroundTransparency = 0.999,
          BorderColor3 = Color3.fromRGB(0, 0, 0),
          BorderSizePixel = 0,
          Position = UDim2.new(0, 10, 0, 23),
          Size = UDim2.new(1, -180, 0, 12),
          Name = "DropdownContent",
          Parent = Dropdown
        })
        
				DropdownContent.Size = UDim2.new(1, -180, 0, 12 + (12 * (DropdownContent.TextBounds.X // DropdownContent.AbsoluteSize.X)))
				DropdownContent.TextWrapped = true
				Dropdown.Size = UDim2.new(1, 0, 0, DropdownContent.AbsoluteSize.Y + 33)
        
        DropdownContent:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
          DropdownContent.TextWrapped = false
            
					DropdownContent.Size = UDim2.new(1, -180, 0, 12 + (12 * (DropdownContent.TextBounds.X // DropdownContent.AbsoluteSize.X)))
					Dropdown.Size = UDim2.new(1, 0, 0, DropdownContent.AbsoluteSize.Y + 33)
            
          DropdownContent.TextWrapped = true

          UpdateSizeSection()
        end)

        local SelectOptionsFrame = Custom:Create("Frame", {
          AnchorPoint = Vector2.new(1, 0.5),
          BackgroundColor3 = Color3.fromRGB(255, 255, 255),
          BackgroundTransparency = 0.95,
          BorderColor3 = Color3.fromRGB(0, 0, 0),
          BorderSizePixel = 0,
          Position = UDim2.new(1, -7, 0.5, 0),
          Size = UDim2.new(0, 148, 0, 30),
          Name = "SelectOptionsFrame",
          LayoutOrder = CountDropdown
        }, Dropdown)

        Custom:Create("UICorner", {
          CornerRadius = UDim.new(0, 10)
        }, SelectOptionsFrame)

        DropdownButton.Activated:Connect(function()
          if not MoreBlur.Visible then
            MoreBlur.Visible = true
              
            local tweenInfo = TweenInfo.new(0.1)

            DropPageLayout:JumpToIndex(SelectOptionsFrame.LayoutOrder)
                            
            local BlurTween = TweenService:Create(MoreBlur, tweenInfo, {BackgroundTransparency = 0.7})
            local DropdownTween = TweenService:Create(DropdownSelect, tweenInfo, {Position = UDim2.new(1, -11, 0.5, 0)})
              
            BlurTween:Play()
            DropdownTween:Play()
          end
        end)

        local OptionSelecting = Custom:Create("TextLabel", {
          Font = Enum.Font.GothamBold,
          Text = "",
          TextColor3 = Color3.fromRGB(255, 255, 255),
          TextSize = 12,
          TextTransparency = 0.6,
          TextWrapped = true,
          TextXAlignment = Enum.TextXAlignment.Left,
          AnchorPoint = Vector2.new(0, 0.5),
          BackgroundColor3 = Color3.fromRGB(255, 255, 255),
          BackgroundTransparency = 0.999,
          BorderColor3 = Color3.fromRGB(0, 0, 0),
          BorderSizePixel = 0,
          Position = UDim2.new(0, 5, 0.5, 0),
          Size = UDim2.new(1, -30, 1, -8),
          Name = "OptionSelecting",
        }, SelectOptionsFrame)

        local OptionImg = Custom:Create("ImageLabel", {
          Image = "rbxassetid://90200523188815",
          ImageColor3 = Color3.fromRGB(231, 231, 231),
          AnchorPoint = Vector2.new(1, 0.5),
          BackgroundColor3 = Color3.fromRGB(255, 255, 255),
          BackgroundTransparency = 0.999,
          BorderColor3 = Color3.fromRGB(0, 0, 0),
          BorderSizePixel = 0,
          Position = UDim2.new(1, 0, 0.5, 0),
          Size = UDim2.new(0, 25, 0, 25),
          Name = "OptionImg",
        }, SelectOptionsFrame)

        local ScrollSelect = Custom:Create("ScrollingFrame", {
          CanvasSize = UDim2.new(0, 0, 0, 0),
          ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0),
          ScrollBarThickness = 0,
          Active = true,
          LayoutOrder = CountDropdown,
          BackgroundColor3 = Color3.fromRGB(255, 255, 255),
          BackgroundTransparency = 0.999,
          BorderColor3 = Color3.fromRGB(0, 0, 0),
          BorderSizePixel = 0,
          Size = UDim2.new(1, 0, 1, 0),
          Name = "ScrollSelect",
        }, DropdownFolder)

        Custom:Create("UIListLayout", {
          Padding = UDim.new(0, 3),
          SortOrder = Enum.SortOrder.LayoutOrder,
        }, ScrollSelect)

        local SearchBar = Custom:Create("TextBox", {
          Font = Enum.Font.GothamBold,
          PlaceholderText = "Search",
          PlaceholderColor3 = Color3.fromRGB(120, 120, 120),
          Text = "",
          TextColor3 = Color3.fromRGB(255, 255, 255),
          TextSize = 12,
          BackgroundColor3 = Color3.fromRGB(0, 0, 0),
          BackgroundTransparency = 0.9,
          BorderColor3 = Color3.fromRGB(255, 0, 0),
          BorderSizePixel = 1,
          Size = UDim2.new(1, 0, 0, 20),
          Name = "SearchBar"
        }, ScrollSelect)

        SearchBar:GetPropertyChangedSignal("Text"):Connect(function()
          local SearchText = string.lower(SearchBar.Text)

          for _, v in pairs(ScrollSelect:GetChildren()) do
            if v:IsA("Frame") and v.Name == "Option" and v.Name ~= "SearchBar" then
              local OptionText = v:FindFirstChild("OptionText")
              if OptionText then
                v.Visible = string.find(string.lower(OptionText.Text), SearchText) ~= nil
              end
            end
          end
        end)

        local DropCount = 0

        function Funcs_Dropdown:Clear()
          for _, DropFrame in pairs(ScrollSelect:GetChildren()) do
            if DropFrame.Name == "Option" then
              Funcs_Dropdown.Value = {}
              Funcs_Dropdown.Options = {}
              OptionSelecting.Text = "Select Options"
              DropFrame:Destroy()
            end
          end
        end
        
        function Funcs_Dropdown:Set(Value)
          Funcs_Dropdown.Value = Value or Funcs_Dropdown.Value

          for _, Drop in pairs(ScrollSelect:GetChildren()) do
            if Drop.Name ~= "UIListLayout" and Drop.Name ~= "SearchBar" then
              local isTextFound = table.find(Funcs_Dropdown.Value, Drop.OptionText.Text)
              local tweenInfoInOut = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)

              local Size = isTextFound and UDim2.new(0, 1, 0, 12) or UDim2.new(0, 0, 0, 0)
              local BackgroundTransparency = isTextFound and 0.935 or 0.999
              local Transparency = isTextFound and 0 or 0.999
          
              TweenService:Create(Drop.ChooseFrame, tweenInfoInOut, {Size = Size}):Play()
              TweenService:Create(Drop.ChooseFrame.UIStroke, tweenInfoInOut, {Transparency = Transparency}):Play()
              TweenService:Create(Drop, tweenInfoInOut, {BackgroundTransparency = BackgroundTransparency}):Play()
            end
          end
        
          local DropdownValueTable = table.concat(Funcs_Dropdown.Value, ", ")
          OptionSelecting.Text = DropdownValueTable ~= "" and DropdownValueTable or "Select Options"
          Callback(Funcs_Dropdown.Value)
        end

        function Funcs_Dropdown:AddOption(OptionName)
          OptionName = OptionName or "Option"
  
          local Option = Custom:Create("Frame", {
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 0.999,
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            BorderSizePixel = 0,
            LayoutOrder = DropCount,
            Size = UDim2.new(1, 0, 0, 30),
            Name = "Option"
          }, ScrollSelect)
  
          Custom:Create("UICorner", {
            CornerRadius = UDim.new(0, 8)
          }, Option)
  
          local OptionButton = Custom:Create("TextButton", {
            Font = Enum.Font.GothamBold,
            Text = "",
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextSize = 13,
            TextXAlignment = Enum.TextXAlignment.Left,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 0.999,
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 1, 0),
            Name = "OptionButton"
          }, Option)
  
          Custom:Create("TextLabel", {
            Font = Enum.Font.GothamBold,
            Text = OptionName,
            TextSize = 13,
            TextColor3 = Color3.fromRGB(230, 230, 230),
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Top,
            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
            BackgroundTransparency = 0.999,
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            BorderSizePixel = 0,
            Position = UDim2.new(0, 8, 0, 8),
            Size = UDim2.new(1, -100, 0, 13),
            Name = "OptionText"
          }, Option)
  
          local ChooseFrame = Custom:Create("Frame", {
            AnchorPoint = Vector2.new(0, 0.5),
            BackgroundColor3 = Custom.ColorRGB,
            BorderColor3 = Color3.fromRGB(0, 0, 0),
            BorderSizePixel = 0,
            Position = UDim2.new(0, 2, 0.5, 0),
            Size = UDim2.new(0, 0, 0, 0),
            Name = "ChooseFrame"
          }, Option)
  
          Custom:Create("UIStroke", {
            Color = Custom.ColorRGB,
            Thickness = 1.6,
            Transparency = 0.999
          }, ChooseFrame)
  
          Custom:Create("UICorner", {}, ChooseFrame)
  
          OptionButton.Activated:Connect(function()

            CircleClick(OptionButton, Player:GetMouse().X, Player:GetMouse().Y)
        
            local isOptionSelected = Option.BackgroundTransparency > 0.95

            if Multi then
              if isOptionSelected then
                if not table.find(Funcs_Dropdown.Value, OptionName) then
                  table.insert(Funcs_Dropdown.Value, OptionName)
                end
              else
                for i, value in ipairs(Funcs_Dropdown.Value) do
                  if value == OptionName then
                    table.remove(Funcs_Dropdown.Value, i)
                    break
                  end
                end
              end
            else
              Funcs_Dropdown.Value = {OptionName}
            end

            Funcs_Dropdown:Set(Funcs_Dropdown.Value)
          end)
        
          local function UpdateCanvasSize()
            local OffsetY = 0

            for _, child in ipairs(ScrollSelect:GetChildren()) do
              if child.Name ~= "UIListLayout" and child.Name ~= "SearchBar" then
                OffsetY = OffsetY + 5 + child.Size.Y.Offset
              end
            end

            ScrollSelect.CanvasSize = UDim2.new(0, 0, 0, OffsetY)
          end
        
          UpdateCanvasSize()

          DropCount += 1
        end

        function Funcs_Dropdown:Refresh(RefreshList, Selecting)
          RefreshList = RefreshList or {}
          Selecting = Selecting or {}
          
          Funcs_Dropdown:Clear()
          
          for _, Drop in ipairs(RefreshList) do
            Funcs_Dropdown:AddOption(Drop)
          end
      
          Funcs_Dropdown.Options = RefreshList
          Funcs_Dropdown:Set(Selecting)
        end
      
        Funcs_Dropdown:Refresh(Funcs_Dropdown.Options, Funcs_Dropdown.Value)
      
        ItemCount += 1
        CountDropdown += 1
        return Funcs_Dropdown
      end

      ItemCount += 1
      return Item
    end

    CountTab += 1
    return Sections
  end

  return Tabs
end


return Speed_Library

