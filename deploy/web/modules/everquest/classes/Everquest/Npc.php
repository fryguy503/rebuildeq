<?php defined('SYSPATH') or die('No direct script access.');

//Handles Business Logic for comments
//This represents various social network connections.
class Everquest_Npc extends Everquest {

      public function find_all_by_name($name, $limit, $offset) {
            $name = str_replace(" ", "_", $name);
            $npc = DB::select("n.*, REPLACE(n.name, '_', ' ') clean_name")
            ->from('npc_types n')
            /*->join('spawnentry se')->on('se.npcID', '=', 'n.id')
            ->join('spawngroup sg')->on('sg.id', '=', 'se.spawngroupID')
            ->join('spawn2 s')->on('s.spawngroupID', '=', 'se.spawngroupID')
            */
            ->where('n.name COLLATE latin1_general_ci', 'LIKE', "%$name%")
            ->limit($limit)
            ->offset($offset)
            ->as_object()->execute()->as_array();
            if (empty($npc)) return;

            return $npc;            
      }

      public function find_total_by_name($name) {
      
            $npc = DB::select("count(*)")
            ->from('npc_types n')
            /*->join('spawnentry se')->on('se.npcID', '=', 'n.id')
            ->join('spawngroup sg')->on('sg.id', '=', 'se.spawngroupID')
            ->join('spawn2 s')->on('s.spawngroupID', '=', 'se.spawngroupID')
            */
            ->where('n.name', 'LIKE', "%$name%")
            ->execute()->get('count(*)');

            return $npc;
      }


      public function get_by_npc_id($id) {

            $npc = DB::select("n.*")
            ->from('npc_types n')
            /*->join('spawnentry se')->on('se.npcID', '=', 'n.id')
            ->join('spawngroup sg')->on('sg.id', '=', 'se.spawngroupID')
            ->join('spawn2 s')->on('s.spawngroupID', '=', 'se.spawngroupID')
            */
            ->where('n.id', '=', $id)
            ->limit(1)
            ->execute()->current();

            return $npc;
      }

}
