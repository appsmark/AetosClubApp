import { ApplicationSettings } from "@nativescript/core";
export class DataGame {
    max_ranking_items = 20
    max_schedule_items = 40
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
    
    init() {
        this.max_teams = this.teams.length
        this.team = ApplicationSettings.getNumber("Team")
    }

    setTeam() {
		this.team = this.team_desired
        ApplicationSettings.setNumber("Team", parseInt(this.team))
    }
}
