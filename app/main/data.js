import { ApplicationSettings } from "@nativescript/core";
export class DataGame {
    all_buttons = false
    beach_date  // Date of selected day to show beach info
    beach_field = 0
    max_beach_players = 6
    color_blue = "#00AADE"
    color_yellow = "#F9B234"
    color_brown = "#731816"
    days = ["Zon", "Maan", "Dins", "Woens", "Donder", "Vrij", "Zater"]
    max_fields = 4
    max_ranking_items = 12
    max_schedule_items = 2 * this.max_ranking_items
    max_teams
    team
	team_desired = 0
    teams = [
        ["D1", "regio-oost/DPD", "dames/1"],
        ["D2", "regio-oost/D1M", "dames/2"],
        ["D3", "regio-oost/D1L", "dames/3"],
        ["D4", "regio-oost/D1M", "dames/4"],
        ["D5", "regio-oost/D1L", "dames/5"],
        ["D6", "regio-oost/D2N", "dames/6"],
        ["D7", "regio-oost/D3O", "dames/7"],
        ["D8", "regio-oost/D3P", "dames/8"],
        ["D9", "regio-oost/D3O", "dames/9"],
        ["D10", "regio-oost/D4I", "dames/10"],
        ["H1", "nationale-competitie/2BH", "heren/1"],
        ["H2", "regio-oost/HPD", "heren/2"],
        ["H3", "regio-oost/HPD", "heren/3"],
        ["H4", "regio-oost/H1G", "heren/4"],
        ["H5", "regio-oost/H1G", "heren/5"],
        ["H6", "regio-oost/H3E", "heren/6"],
        ["H7", "regio-oost/H3E", "heren/7"],
        ["JA1", "regio-oost/JA1C2", "jongens-a/1"],
        ["JA2", "regio-oost/JA1C2", "jongens-a/2"],
        ["MA1", "regio-oost/MA2I2", "meisjes-a/1"],
        ["MA2", "regio-oost/MA2I2", "meisjes-a/2"],
        ["MA3", "regio-oost/MA2I2", "meisjes-a/3"],
        ];
    
        players = [
            "---",
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
