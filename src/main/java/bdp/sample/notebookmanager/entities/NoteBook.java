package bdp.sample.notebookmanager.entities;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.UpdateTimestamp;
import org.springframework.hateoas.RepresentationModel;

import javax.persistence.*;
import java.sql.Timestamp;
import java.util.Objects;

@Entity
@Getter
@Setter
@NoArgsConstructor
public class NoteBook extends RepresentationModel<NoteBook> {
    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer ID;

    @Basic
    @Column(name = "name", unique = true)
    private String name;

    @Basic
    @Column(name = "currentPrice")
    private double currentPrice;

    @Basic
    @Column(name = "lastUpdate")
    @UpdateTimestamp
    private Timestamp lastUpdate;

    public NoteBook(Integer ID, String name, double currentPrice) {
        this.ID = ID;
        this.name = name;
        this.currentPrice = currentPrice;
    }

    public NoteBook(String name, double currentPrice) {
        this.name = name;
        this.currentPrice = currentPrice;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        if (!super.equals(o)) return false;
        NoteBook notebook = (NoteBook) o;
        return Double.compare(notebook.currentPrice, currentPrice) == 0 &&
                Objects.equals(ID, notebook.ID) &&
                Objects.equals(name, notebook.name) &&
                Objects.equals(lastUpdate, notebook.lastUpdate);
    }

    @Override
    public int hashCode() {
        return Objects.hash(super.hashCode(), ID, name, currentPrice, lastUpdate);
    }
}
