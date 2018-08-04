ALTER TABLE `ground_spawns` MODIFY `respawn_timer` int(11) unsigned NOT NULL default 300;
UPDATE `ground_spawns` SET `respawn_timer` = `respawn_timer` / 1000;

select e.npc_spells_id, e.spellid from npc_spells_entries as e inner join spells_new as s on e.spellid = s.id where e.recast_delay = -1 and s.recast_time = 0 and e.priority = 0 and e.type = 1 order by e.npc_spells_id;

ALTER TABLE `npc_spells_entries` ADD `min_hp` SMALLINT(5) DEFAULT '0';
ALTER TABLE `npc_spells_entries` ADD `max_hp` SMALLINT(5) DEFAULT '0';

ALTER TABLE `npc_types` ADD `charm_ac` SMALLINT(5) DEFAULT '0';
ALTER TABLE `npc_types` ADD `charm_min_dmg` INT(10) DEFAULT '0';
ALTER TABLE `npc_types` ADD `charm_max_dmg` INT(10) DEFAULT '0';
ALTER TABLE `npc_types` ADD `charm_attack_delay` TINYINT(3) DEFAULT '0';
ALTER TABLE `npc_types` ADD `charm_accuracy_rating` MEDIUMINT(9) DEFAULT '0';
ALTER TABLE `npc_types` ADD `charm_avoidance_rating` MEDIUMINT(9) DEFAULT '0';
ALTER TABLE `npc_types` ADD `charm_atk` MEDIUMINT(9) DEFAULT '0';

ALTER TABLE `npc_types` ADD `skip_global_loot` TINYINT DEFAULT '0';
ALTER TABLE `npc_types` ADD `rare_spawn` TINYINT DEFAULT '0';

CREATE TABLE global_loot (
	id INT NOT NULL AUTO_INCREMENT,
	description varchar(255),
	loottable_id INT NOT NULL,
	enabled TINYINT NOT NULL DEFAULT 1,
	min_level INT NOT NULL DEFAULT 0,
	max_level INT NOT NULL DEFAULT 0,
	rare TINYINT NULL,
	raid TINYINT NULL,
	race MEDIUMTEXT NULL,
	class MEDIUMTEXT NULL,
	bodytype MEDIUMTEXT NULL,
	zone MEDIUMTEXT NULL,
	PRIMARY KEY (id)
);

UPDATE spawn2 SET heading = heading * 8.0 / 4.0;
UPDATE grid_entries SET heading = heading * 8.0 / 4.0 WHERE heading <> -1;
INSERT INTO variables (varname, value) VALUES ('fixed_heading', 1); -- hack

CREATE TABLE `bug_reports` (
	`id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
	`zone` VARCHAR(32) NOT NULL DEFAULT 'Unknown',
	`client_version_id` INT(11) UNSIGNED NOT NULL DEFAULT '0',
	`client_version_name` VARCHAR(24) NOT NULL DEFAULT 'Unknown',
	`account_id` INT(11) UNSIGNED NOT NULL DEFAULT '0',
	`character_id` INT(11) UNSIGNED NOT NULL DEFAULT '0',
	`character_name` VARCHAR(64) NOT NULL DEFAULT 'Unknown',
	`reporter_spoof` TINYINT(1) NOT NULL DEFAULT '1',
	`category_id` INT(11) UNSIGNED NOT NULL DEFAULT '0',
	`category_name` VARCHAR(64) NOT NULL DEFAULT 'Other',
	`reporter_name` VARCHAR(64) NOT NULL DEFAULT 'Unknown',
	`ui_path` VARCHAR(128) NOT NULL DEFAULT 'Unknown',
	`pos_x` FLOAT NOT NULL DEFAULT '0',
	`pos_y` FLOAT NOT NULL DEFAULT '0',
	`pos_z` FLOAT NOT NULL DEFAULT '0',
	`heading` INT(11) UNSIGNED NOT NULL DEFAULT '0',
	`time_played` INT(11) UNSIGNED NOT NULL DEFAULT '0',
	`target_id` INT(11) UNSIGNED NOT NULL DEFAULT '0',
	`target_name` VARCHAR(64) NOT NULL DEFAULT 'Unknown',
	`optional_info_mask` INT(11) UNSIGNED NOT NULL DEFAULT '0',
	`_can_duplicate` TINYINT(1) NOT NULL DEFAULT '0',
	`_crash_bug` TINYINT(1) NOT NULL DEFAULT '0',
	`_target_info` TINYINT(1) NOT NULL DEFAULT '0',
	`_character_flags` TINYINT(1) NOT NULL DEFAULT '0',
	`_unknown_value` TINYINT(1) NOT NULL DEFAULT '0',
	`bug_report` VARCHAR(1024) NOT NULL DEFAULT '',
	`system_info` VARCHAR(1024) NOT NULL DEFAULT '',
	`report_datetime` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`bug_status` TINYINT(3) UNSIGNED NOT NULL DEFAULT '0',
	`last_review` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	`last_reviewer` VARCHAR(64) NOT NULL DEFAULT 'None',
	`reviewer_notes` VARCHAR(1024) NOT NULL DEFAULT '',
	PRIMARY KEY (`id`),
	UNIQUE INDEX `id` (`id`)
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;

INSERT INTO `rule_values` (`ruleset_id`, `rule_name`, `rule_value`, `notes`) VALUES
(1, 'Bugs:ReportingSystemActive', 'true', 'Activates bug reporting'),
(1, 'Bugs:UseOldReportingMethod', 'true', 'Forces the use of the old bug reporting system'),
(1, 'Bugs:DumpTargetEntity', 'false', 'Dumps the target entity, if one is provided');

ALTER TABLE `tasks` ADD `type` TINYINT NOT NULL DEFAULT '0' AFTER `id`;
ALTER TABLE `tasks` ADD `duration_code` TINYINT NOT NULL DEFAULT '0' AFTER `duration`;
UPDATE `tasks` SET `type` = '2'; -- we were treating them all as quests

ALTER TABLE `character_tasks` ADD `type` TINYINT NOT NULL DEFAULT '0' AFTER `slot`;
UPDATE `character_tasks` SET `type` = '2'; -- we were treating them all as quests

ALTER TABLE `activities` ADD `target_name` VARCHAR(64) NOT NULL DEFAULT '' AFTER `activitytype`;
ALTER TABLE `activities` ADD `item_list` VARCHAR(128) NOT NULL DEFAULT '' AFTER `target_name`;
ALTER TABLE `activities` ADD `skill_list` VARCHAR(64) NOT NULL DEFAULT '-1' AFTER `item_list`;
ALTER TABLE `activities` ADD `spell_list` VARCHAR(64) NOT NULL DEFAULT '0' AFTER `skill_list`;
ALTER TABLE `activities` ADD `description_override` VARCHAR(128) NOT NULL DEFAULT '' AFTER `spell_list`;
ALTER TABLE `activities` ADD `zones` VARCHAR(64) NOT NULL DEFAULT '' AFTER `zoneid`;
UPDATE `activities` SET `description_override` = `text3`;
UPDATE `activities` SET `target_name` = `text1`;
UPDATE `activities` SET `item_list` = `text2`;
UPDATE `activities` SET `zones` = `zoneid`; -- should be safe for us ...
ALTER TABLE `activities` DROP COLUMN `text1`;
ALTER TABLE `activities` DROP COLUMN `text2`;
ALTER TABLE `activities` DROP COLUMN `text3`;
ALTER TABLE `activities` DROP COLUMN `zoneid`;

CREATE TABLE `data_buckets` (
  `id` bigint(11) unsigned NOT NULL AUTO_INCREMENT,
  `key` varchar(100) DEFAULT NULL,
  `value` text,
  `expires` int(11) unsigned DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `key_index` (`key`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4;


ALTER TABLE `tasks` DROP COLUMN `startzone`;
ALTER TABLE `tasks` ADD `faction_reward` INT(10) NOT NULL DEFAULT '0';

RENAME TABLE `activities` TO `task_activities`;

ALTER TABLE `tasks` ADD `completion_emote` VARCHAR(128) NOT NULL DEFAULT '';