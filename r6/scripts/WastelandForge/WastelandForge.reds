// Wasteland Forge - Codeware DynamicEntitySystem bridge
// Runtime proof: spawn/delete a managed entity near V.

public class WastelandForgeSystem extends ScriptableSystem {
  private let entitySystem: wref<DynamicEntitySystem>;
  private let lastEntity: EntityID;

  private func EnsureSystem() -> Bool {
    this.entitySystem = GameInstance.GetDynamicEntitySystem();
    return IsDefined(this.entitySystem) && this.entitySystem.IsReady();
  }

  public func SpawnTemplate(path: ResRef, position: Vector4, orientation: Quaternion) -> EntityID {
    if !this.EnsureSystem() {
      LogChannel(n"DEBUG", "[WastelandForge] DynamicEntitySystem not ready");
      return this.lastEntity;
    };

    let spec = new DynamicEntitySpec();
    spec.templatePath = path;
    spec.position = position;
    spec.orientation = orientation;
    spec.persistState = false;
    spec.persistSpawn = false; // Forge owns persistence through settlement.json.
    spec.alwaysSpawned = false;
    spec.spawnInView = true;
    spec.active = true;
    spec.tags = [n"WastelandForge"];

    this.lastEntity = this.entitySystem.CreateEntity(spec);
    return this.lastEntity;
  }

  public func SpawnTestAtPlayer() -> EntityID {
    let player = GetPlayer(this.GetGameInstance());
    if !IsDefined(player) {
      return this.lastEntity;
    };

    let position = player.GetWorldPosition();
    position.X += 2.0;

    // Known base-game entity template used as a runtime smoke test.
    return this.SpawnTemplate(
      r"base\gameplay\devices\drop_points\drop_point.ent",
      position,
      player.GetWorldOrientation()
    );
  }

  public func DeleteLast() -> Bool {
    if !this.EnsureSystem() {
      return false;
    };
    return this.entitySystem.DeleteEntity(this.lastEntity);
  }
}

@addMethod(PlayerPuppet)
public func WastelandForgeSpawnTest() -> EntityID {
  let system = GameInstance.GetScriptableSystemsContainer(this.GetGame())
    .Get(n"WastelandForgeSystem") as WastelandForgeSystem;
  return system.SpawnTestAtPlayer();
}
