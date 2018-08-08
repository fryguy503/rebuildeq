export class SkillConfig {
	public build: Build;
	public element: Element;
}

export class Skill {
	private element:Element;
	private spentPoints:number = 0;
	public _build: Build;
	private index:number;

	constructor(params) {
		this.build = params.build;
		this.element = params.element;
		
		this.index = parseInt(this.element.getAttribute("index"))
		this.element.addEventListener("mousedown", (e: MouseEvent) => { this.onMouseDown(e); }, false)
	}

	get build(): Build {
		return this._build;
	}

	set build(build:Build) {
		this._build = build;
	}

	public GetSpentPoints():number {
		return this.spentPoints;
	}

	public SetSpentPoints(value:number) {
		this.spentPoints = value;
	}

	public AddPoint(value:number) {
		this.spentPoints += value;
	}

	public GetIndex() {
		return this.index;
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
	private skills:Map<number, Skill> = new Map();

	public SetSkills(skills:Map<number, Skill>) {
		this.skills = skills;
	}

	public SpendPoint(skill:Skill, value:number) {
		if (this.isLocked) return;
		if (skill.GetSpentPoints() >= 5) {
			console.log("can't spend point, skill already max");
			return;
		}
		if (this.spentPoints >= this.level) {
			console.log("can't spend point, all points spent for level")
			return
		}
		//check getTreeTotal

		//request ajax

		this.spentPoints++;
		skill.AddPoint(1);
		
		console.log(this.getBuild());
	}

	private getTreeTotal(skill:Skill):number {
		let spent = 0;

		return spent;
	}

	private getBuild():string {
		let build = "";
		for (let i = 0; i < 32; i++) {
			let skill = this.skills.get(i);
			if (skill == null) {
				build += "0";
				continue;
			}
			build += skill.GetSpentPoints();
		}
		return build;
	}
}


window.onload = () => {
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
		skills.set(skill.GetIndex(), skill);
	}
	build.SetSkills(skills);
}