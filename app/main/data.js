import { ApplicationSettings } from "@nativescript/core";
export class DataGame {
    all_buttons = false
    beach_date  // Date of selected day to show beach info
    beach_field = 0
    beach_login = false
    max_beach_players = 6
    color_blue = "#00AADE"      //   0 170 222
    color_yellow = "#F9B234"    // 249 178  52
    color_brown = "#731816"     // 115  24  22
    days = ["Zon", "Maan", "Dins", "Woens", "Donder", "Vrij", "Zater"]
    max_fields = 4
    max_duty_items = 13
    max_ranking_items = 12
    max_schedule_items = 2 * this.max_ranking_items
    max_teams
    team = 15
	team_desired = 0
    teams = [
        ["D1", "regio-oost/DPC", "dames/1"],
        ["D2", "regio-oost/D1L", "dames/2"],
        ["D3", "regio-oost/D1L", "dames/3"],
        ["D4", "regio-oost/D1M", "dames/4"],
        ["D5", "regio-oost/D1M", "dames/5"],
        ["D6", "regio-oost/D2I", "dames/6"],
        ["D7", "regio-oost/D2N", "dames/7"],
        ["D8", "regio-oost/D3J", "dames/8"],
        ["D9", "regio-oost/D3M", "dames/9"],
        ["D10", "regio-oost/D3M", "dames/10"],
        ["H1", "nationale-competitie/2BH", "heren/1"],
        ["H2", "regio-oost/HPD", "heren/2"],
        ["H3", "regio-oost/HPD", "heren/3"],
        ["H4", "regio-oost/H1G", "heren/4"],
        ["H5", "regio-oost/H1H", "heren/5"],
        ["H6", "regio-oost/H2G", "heren/6"],
        ["H7", "regio-oost/H2J", "heren/7"],
        ["H8", "regio-oost/H3E", "heren/8"],
        ["H9", "regio-oost/H3F", "heren/9"],
        ["JA1", "regio-oost/JAHA1", "jongens-a/1"],
        ["JA2", "regio-oost/JA1C1", "jongens-a/2"],
        ["JB1", "regio-oost/JBHA1", "jongens-b/1"],
        ["JB2", "regio-oost/JB2D1", "jongens-b/2"],
        ["JC1", "regio-oost/JCHB1", "jongens-c/1"],
        ["JC2", "regio-oost/JC2C1", "jongens-c/2"],
        ["JC3", "regio-oost/JC2C1", "jongens-c/3"],
        ["MA1", "regio-oost/MA1H1", "meisjes-a/1"],
        ["MA2", "regio-oost/MA1G1", "meisjes-a/2"],
        ["MA3", "regio-oost/MA1G1", "meisjes-a/3"],
        ["MA4", "regio-oost/MA1H1", "meisjes-a/4"],
        ["MA5", "regio-oost/MA3D1", "meisjes-a/5"],
        ["MB1", "regio-oost/MBHC1", "meisjes-b/1"],
        ["MB2", "regio-oost/MB1H1", "meisjes-b/2"],
        ["MB3", "regio-oost/MB2K1", "meisjes-b/3"],
        ["MB4", "regio-oost/MB3I1", "meisjes-b/4"],
        ["MB5", "regio-oost/MB3I1", "meisjes-b/5"],
        ["MC1", "regio-oost/MC1E1", "meisjes-c/1"],
        ["MC2", "regio-oost/MC1E1", "meisjes-c/2"],
        ["MC3", "regio-oost/MC2K1", "meisjes-c/3"],
        ["MC4", "regio-oost/MC2K1", "meisjes-c/4"],
        ["MC5", "regio-oost/MC3N1", "meisjes-c/5"],
        ["MC6", "regio-oost/MC3M1", "meisjes-c/6"],
        ["MC7", "regio-oost/MC3M1", "meisjes-c/7"],
        ];
    
        players = [
            "--------------",
            "Martin Keesen",
            "Dick Tuinier",
            "Erno Breedveld",
            "Martijn van Duuren",
            "Hans Heijwegen",
            "Nathan Derksen",
            "Rob Jansen",
            "Jack van der Beek",
            "Wim de Haan",
            "Pietje Puk",
            "Jan Smashmaar",
            "Strandjutter",
            "Zo die is goed"
        ]

        fields = [
            [
                [ 1, 0, 0, 0, 0, 0],
                [ 2, 3, 0, 0, 0, 0],
                [ 4, 5, 6, 7, 8, 9],
                [ 0, 0, 0, 0, 0, 0]
            ],
            [
                [ 10, 13, 0, 0, 0, 0],
                [ 12, 0, 0, 0, 0, 0],
                [ 0, 0, 0, 0, 0, 0],
                [ 0, 0, 0, 0, 0, 0]
            ],
            [
                [ 7, 8, 9, 1, 2, 3],
                [ 3, 10, 11, 0, 0, 0],
                [ 0, 0, 0, 0, 0, 0],
                [ 0, 0, 0, 0, 0, 0]
            ],
            [
                [ 4, 5, 6, 7, 0, 0],
                [ 8, 9, 10, 11, 0, 0],
                [ 0, 0, 0, 0, 0, 0],
                [ 0, 0, 0, 0, 0, 0]
            ],
            [
                [ 0, 0, 0, 0, 0, 0],
                [ 0, 0, 0, 0, 0, 0],
                [ 0, 0, 0, 0, 0, 0],
                [ 1, 2, 10, 11, 0, 0]
            ]
        ]
                                        
    init() {
        this.max_teams = this.teams.length
        this.team = ApplicationSettings.getNumber("YourTeam")
    }

    changeStateAllButtons() {
        this.all_buttons = !this.all_buttons
    }
		

    setTeam() {
		this.team = this.team_desired
        ApplicationSettings.setNumber("YourTeam", parseInt(this.team))
    }
}
