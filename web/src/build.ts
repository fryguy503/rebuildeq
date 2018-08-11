export class SkillConfig {
	public build: Build;
	public element: Element;
}

export class Skill {
	private element:Element;
	private spentPoints:number = 0;
	private _build: Build;
	private _index:number = 0;
	private _points:number = 0;

	constructor(params) {
		this.build = params.build;
		this.element = params.element;

		if (this.element == null) return;
		this.index = parseInt(this.element.getAttribute("index"))
		this.element.addEventListener("mousedown", (e: MouseEvent) => { this.onMouseDown(e); }, false)
	}

	get build(): Build {
		return this._build;
	}

	set build(build:Build) {
		this._build = build;
	}

	get index(): number {
		return this._index;
	}

	set index(index:number) {
		this._index = index;
	}

	get points(): number {
		return this._points;
	}

	set points(points:number) {		
		this._points = points;
	}

	private onMouseDown(event:MouseEvent) {
		console.log(this._build);
		event.preventDefault();
		switch (event.which) {
			case 1: //left mouse button
				this.build.SpendPoint(this, 1);				
				break;
		}
	}
}


export class Build {
	private isLocked:boolean = false;
	private level:number = 60;
	private spentPoints:number = 0;
	private _skills:Map<number, Skill> = new Map();

	
	get skills(): Map<number, Skill> {
		return this._skills;
	}

	set skills(skills:Map<number, Skill>) {
		this._skills = skills;
	}

	public LoadHash(hash:string) {
		//build a temporary skill list
		let skills = new Map<number, Skill>();
		for (let i = 0; i < 53; i++) {
			let value = 0;
			if (hash.length < i) {
				value = 0;
			} else {
				value = parseInt(hash.substr(0,1))
			}
			//Make dummy skill
			let skill = new Skill({});			
			skill.points = value;
		}
		let reason = this.isValid(skills);
		if (reason != "") {
			console.log("failed to parse: "+reason);
			return;
		}
		for (let i = 0; i < 53; i++) {
			let skill = this.skills.get(i);
			if (skill == null) continue;
			let newSkill = skills.get(i);
			if (newSkill == null) continue;
			skill.points = newSkill.points;
		}
		console.log("loaded hash, result:"+this.getHash());
	}

	public SpendPoint(skill:Skill, value:number) {
		console.log("spending point at "+skill.index+" to value "+value);
		if (this.isLocked) return;
		if (skill.points >= 5) {
			console.log("can't spend point, skill already max");
			return;
		}
		if (this.spentPoints >= this.level) {
			console.log("can't spend point, all points spent for level");
			return;
		}

		//attempt for validation
		skill.points += 1;
		this.spentPoints++;
		let reason = this.isValid(this.skills);
		if (reason != "") {
			skill.points -= 1;
			this.spentPoints--;
			console.log("can't spend points: "+reason);
			return;
		}
		
		//request ajax

		
		console.log(this.getHash());
	}

	private getHash():string {
		let hash = "";
		for (let i = 0; i < 53; i++) {
			let value = this.getSkillPoints(i);
			hash += value;
		}
		return hash;
	}

	//is a skilltree valid?
	private isValid(skills:Map<number, Skill>):string {
		if (skills == null) return "internal error, null skills used";
		
		let disabled:number[] = [1,3,5,7,9,11,12,14,15,17,19,21,23,25,27,29,30,32,33,35,37,39,41,43,45,47,48,50,51,53];
		for (let i = 0; i < disabled.length; i++) {			
			if (this.getSkillPoints(disabled[i]) > 0) return "this skill is not valid";
		}

		let req = 5;

		//each tree is an abbreviation, l = left tree. the number is the row. layer 1 = top row
		let l1 = this.getSkillPoints(0) + this.getSkillPoints(1) + this.getSkillPoints(2)
		let m1 = this.getSkillPoints(18) + this.getSkillPoints(19) + this.getSkillPoints(20)
		let r1 = this.getSkillPoints(36) + this.getSkillPoints(37) + this.getSkillPoints(38)

		let l2 = this.getSkillPoints(3) + this.getSkillPoints(4) + this.getSkillPoints(5)
		let m2 = this.getSkillPoints(21) + this.getSkillPoints(22) + this.getSkillPoints(23)
		let r2 = this.getSkillPoints(39) + this.getSkillPoints(40) + this.getSkillPoints(41)

		if ((l1 < req && l2 > 0) || (m1 < req && m2 > 0) || (r1 < req && r2 > 0)) return "at least 5 points must be spent in the prior row";

		l2 += l1;
		m2 += m1;
		r2 += r1;
		req = 10;

		let l3 = this.getSkillPoints(6) + this.getSkillPoints(7) + this.getSkillPoints(8)
		let m3 = this.getSkillPoints(24) + this.getSkillPoints(25) + this.getSkillPoints(26)
		let r3 = this.getSkillPoints(42) + this.getSkillPoints(43) + this.getSkillPoints(44)

		if ((l2 < req && l3 > 0) || (m2 < req && m3 > 0) || (r2 < req && r3 > 0)) return "at least 5 points must be spent in the prior row";

		l3 += l2;
		m3 += m2;
		r3 += r2;
		req = 15;

		let l4 = this.getSkillPoints(9) + this.getSkillPoints(10) + this.getSkillPoints(11)
		let m4 = this.getSkillPoints(27) + this.getSkillPoints(28) + this.getSkillPoints(29)
		let r4 = this.getSkillPoints(45) + this.getSkillPoints(46) + this.getSkillPoints(47)

		if ((l3 < req && l4 > 0) || (m3 < req && m4 > 0) || (r3 < req && r4 > 0)) return "at least 5 points must be spent in the prior row";

		l4 += l3;
		m4 += m3;
		r4 += r3;
		req = 20;

		let l5 = this.getSkillPoints(12) + this.getSkillPoints(13) + this.getSkillPoints(14)
		let m5 = this.getSkillPoints(30) + this.getSkillPoints(31) + this.getSkillPoints(32)
		let r5 = this.getSkillPoints(48) + this.getSkillPoints(49) + this.getSkillPoints(50)

		if ((l4 < req && l5 > 0) || (m4 < req && m5 > 0) || (r4 < req && r5 > 0)) return "at least 5 points must be spent in the prior row";

		l5 += l4;
		m5 += m4;
		r5 += r4;
		req = 25;

		let l6 = this.getSkillPoints(15) + this.getSkillPoints(16) + this.getSkillPoints(17)
		let m6 = this.getSkillPoints(33) + this.getSkillPoints(34) + this.getSkillPoints(35)
		let r6 = this.getSkillPoints(51) + this.getSkillPoints(52) + this.getSkillPoints(53)

		if ((l5 < req && l6 > 0) || (m5 < req && m6 > 0) || (r5 < req && r6 > 0)) return "at least 5 points must be spent in the prior row";
		
		l6 += l5;
		m6 += m5;
		r6 += r5;
		req = 30;

		return "";
	}

	private getSkillPoints(index:number):number {
		let skill = this.skills.get(index);
		if (skill == null) return 0;
		return skill.points;
	}
}


export function OnWindowLoadBuild() {
	let build = new Build();

	let initialHash = "test"
	//todo: handle initialHash
	//if (initialHash != "test") {
	//	loadHash(initialHash);
	//}
	let skillElements = document.getElementsByClassName("skill")
	let skills = new Map<number, Skill>();
	for (let skillElement of skillElements) {
		let skill = new Skill({element: skillElement, build: build});		
		skills.set(skill.index, skill);
	}
	build.skills = skills;
	console.log("loaded");
}
